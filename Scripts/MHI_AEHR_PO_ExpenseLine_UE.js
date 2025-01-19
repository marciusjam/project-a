/* eslint-disable max-len */
/**
 *@NApiVersion 2.1
 *@NScriptType UserEventScript
 *@description
    Title: Adding expense lines to the purchase order for certain items
    Date: 9/16/24
    Record Type: Purchase Order
    Script Type: User Event Script
    Context: User Interface, CREATE/EDIT
    Custom Field:
    Item Line ID: custcol_aehr_ass_lineid
    ‘Item line id’- Expense sublist column value for associated item line id, on purchase order

    Taxable checkbox on item record: custitem_aehr_po_tax
    ‘Add expense line’ - Item record checkbox to indicate that an expense line needs to be added on the PO

    Description: If there are any non-inventory items that are marked as ‘add expense line’,
    the script should get the item record’s expense account, then add an expense line for the item record.
    Calculate the expense line’s amount value by 10.25% multiplied by the item line’s amount value.
    Set the expense custom column for ‘item line id’ for the expense line pointing to the item sublist item line.
    Recalculate the expense line amount on edit context if the expense line already exists.
    Always check to make sure that an expense line is not duplicated for the item record.
    Also, make sure that the expense line is removed if the related item line is removed.
 */
define(['N/record', 'N/search', 'N/runtime'], (record, search, runtime) => {
  function afterSubmit(context) {
    const { newRecord } = context;
    const { id, type } = newRecord;
    log.debug(`afterSubmit::context::${id}`, context);

    if (!(context.type == context.UserEventType.CREATE || context.type == context.UserEventType.EDIT)) return;
    const rec = record.load({ type, id, isDynamic: true });

    const linesAddedOrEdited = handleExpenseLines(rec);
    const linesRemoved = handleLineRemove(context, rec);
    log.debug(`handleExpenseLines::linesAddedOrEdited::${rec.id}`, linesAddedOrEdited);
    log.debug(`handleExpenseLines::linesRemoved::${rec.id}`, linesRemoved);
    var totalLineAmount = 0;
    var totalActualTaxAmount = 0;

    const numLines = rec.getLineCount({ sublistId: 'item' });
    for (let j = 0; j < numLines; j++) {
      totalLineAmount += rec.getSublistValue({ sublistId: 'item', fieldId: 'amount', line: j});
    }
    

    for (let i = 0; i < numLines; i += 1) {
      const lineId = rec.getSublistValue({ sublistId: 'item', fieldId: 'line', line: i });

      
      const lineNumber = rec.findSublistLineWithValue({ sublistId: 'expense', fieldId: 'custcol_aehr_ass_lineid', value: lineId });
      log.debug(`handleExpenseLines::lineNumber::${rec.id}::${i}`, lineNumber);

      if (lineNumber != -1) {
        totalActualTaxAmount += Number(rec.getSublistValue({ sublistId: 'expense', fieldId: 'custcol_actual_tax', line: lineNumber}));
      }
    }

    log.debug('totalLineAmount',totalLineAmount)
    log.debug('totalActualTaxAmount',totalActualTaxAmount)
    
    rec.setValue({
      fieldId: 'custbody_actual_total_tax',
      value: totalActualTaxAmount.toFixed(5)
    })

    var overallActualTotal = totalLineAmount + totalActualTaxAmount;

    rec.setValue({
      fieldId: 'custbody_actual_total_w_tax',
      value: overallActualTotal.toFixed(5)
    })
    

    if (linesAddedOrEdited || linesRemoved) {
      const savedRecId = rec.save({ ignoreMandatoryFields: true });
      log.debug(`afterSubmit::savedRecId::${id}`, savedRecId);
    }
  }

  /**
   * The functions handles checking the old record against the new record.
   * If any item sublist lines have been removed, remove the related expense line via custcol_aehr_ass_lineid
   * @param {Object} context - netsuite context object
   * @param {Object} rec - netsuite record object
   * @returns {Boolean} - record has changed
   */
  function handleLineRemove(context, rec) {
    let linesRemoved = false;
    if (context.type != context.UserEventType.EDIT) return linesRemoved;

    const { newRecord, oldRecord } = context;

    const newLineData = getLineData(newRecord);
    const oldLineData = getLineData(oldRecord);

    const oldLineIds = Object.keys(oldLineData);

    for (let i = 0; i < oldLineIds.length; i += 1) {
      const oldLineId = oldLineIds[i];

      if (newLineData[oldLineId]) continue; // line still exists, continue
      const lineNumber = rec.findSublistLineWithValue({ sublistId: 'expense', fieldId: 'custcol_aehr_ass_lineid', value: oldLineId });
      if (lineNumber == -1) continue; // there is no related expense line, continue
      rec.removeLine({ sublistId: 'expense', line: lineNumber });
      linesRemoved = true;
    }

    return linesRemoved;
  }

  /**
   * The functions sets up a data object with the key as the line id.
   * This is used to get oldRecord vs newRecord data to see if any lines have been removed from the newRecord
   * @param Object rec - netsuite record object
   * @returns {Object} - line data object
   */
  function getLineData(rec) {
    const lineData = {};
    const headerDepartment = rec.getValue('department');
    const numLines = rec.getLineCount({ sublistId: 'item' });

    for (let i = 0; i < numLines; i += 1) {
      const item = rec.getSublistValue({ sublistId: 'item', fieldId: 'item', line: i });
      const line = rec.getSublistValue({ sublistId: 'item', fieldId: 'line', line: i });
      const department = rec.getSublistValue({ sublistId: 'item', fieldId: 'department', line: i }) || headerDepartment;

      lineData[line] = {
        item,
        department
      };
    }

    return lineData;
  }

  /**
   * The function handles checking if any new item lines have been added or if any existing lines have been editted.
   * The function runs on items where the item record has tax on purchase set.
   * For new item lines, the script adds an expense line
   * For any editted item lines, the script edits the related expense line.
   * @param Object rec - netsuite record object
   * @returns {Boolean} - record has changed
   */
  function handleExpenseLines(rec) {
    const itemIds = getItemIds(rec);
    log.debug(`handleExpenseLines::itemIds::${rec.id}`, itemIds);
    const itemData = getItemData(itemIds);
    log.debug(`handleExpenseLines::itemData::${rec.id}`, itemData);
    const EXPENSE_PERCENTAGE = 0.1025;
    const numLines = rec.getLineCount({ sublistId: 'item' });
    let linesAddedOrEdited = false;
    const headerDepartment = rec.getValue('department');

    for (let i = 0; i < numLines; i += 1) {
      const item = rec.getSublistValue({ sublistId: 'item', fieldId: 'item', line: i });
      const amount = rec.getSublistValue({ sublistId: 'item', fieldId: 'amount', line: i });
      const lineId = rec.getSublistValue({ sublistId: 'item', fieldId: 'line', line: i });
      const department = rec.getSublistValue({ sublistId: 'item', fieldId: 'department', line: i }) || headerDepartment;
      log.debug(`handleExpenseLines::logLine::${rec.id}::${i}`, {
        item,
        amount,
        lineId
      });

      if (
        itemData[item]
         && itemData[item].taxOnPurchase
         && itemData[item].expenseAccount
      ) {
        const lineNumber = rec.findSublistLineWithValue({ sublistId: 'expense', fieldId: 'custcol_aehr_ass_lineid', value: lineId });
        log.debug(`handleExpenseLines::lineNumber::${rec.id}::${i}`, lineNumber);

        if (lineNumber == -1) {
          rec.selectNewLine({ sublistId: 'expense' });
          rec.setCurrentSublistValue({ sublistId: 'expense', fieldId: 'custcol_aehr_ass_lineid', value: lineId });
        } else {
          rec.selectLine({ sublistId: 'expense', line: lineNumber });
        }

        //JOHN TOLENTINO - 12/10/2024
        const taxpartial = rec.getSublistValue({ sublistId: 'item', fieldId: 'custcol_aehr_po_tax_partial', line: i });
        if(taxpartial){
          var expenseAmount = parseFloat(amount)  * 0.063125
        }else{
          var expenseAmount = parseFloat(amount) * EXPENSE_PERCENTAGE
        }

        rec.setCurrentSublistValue({ sublistId: 'expense', fieldId: 'account', value: itemData[item].expenseAccount });
        rec.setCurrentSublistValue({ sublistId: 'expense', fieldId: 'amount', value: expenseAmount.toFixed(5)});
        rec.setCurrentSublistValue({ sublistId: 'expense', fieldId: 'custcol_actual_tax', value: expenseAmount.toFixed(5)});
        rec.setCurrentSublistValue({ sublistId: 'expense', fieldId: 'department', value: department });

        rec.commitLine({ sublistId: 'expense' });
        linesAddedOrEdited = true;
      }
    }

    return linesAddedOrEdited;
  }

  /**
 * Get array of item ids
 *
 * @param {Object} rec - netsuite record object
 * @return {Array} item ids array
 */
  function getItemIds(rec) {
    const itemIds = [];
    const numLines = rec.getLineCount({ sublistId: 'item' });

    for (let i = 0; i < numLines; i += 1) {
      const item = rec.getSublistValue({ sublistId: 'item', fieldId: 'item', line: i });
      if (!itemIds.includes(item)) itemIds.push(item);
    }

    return itemIds;
  }

  /**
 * Get item data via search api
 *
 * @param {Array} itemIds - item ids
 * @return {Object} item data object
 */
  function getItemData(itemIds) {
    const itemData = {};
    if (itemIds.length == 0) return itemData;
    const itemSearchObj = search.create({
      type: 'item',
      filters:
      [
        ['internalid', 'anyof', itemIds]
      ],
      columns:
      [
        search.createColumn({ name: 'internalid', label: 'Internal ID' }),
        search.createColumn({
          name: 'itemid',
          sort: search.Sort.ASC,
          label: 'Name'
        }),
        search.createColumn({ name: 'displayname', label: 'Display Name' }),
        search.createColumn({ name: 'salesdescription', label: 'Description' }),
        search.createColumn({ name: 'type', label: 'Type' }),
        search.createColumn({ name: 'expenseaccount', label: 'Expense/COGS Account' }),
        search.createColumn({ name: 'custitem_aehr_po_tax', label: 'Tax on Purchase' })

      ]
    });
    // const searchResultCount = itemSearchObj.runPaged().count;
    // log.debug('itemSearchObj result count', searchResultCount);
    itemSearchObj.run().each((result) => {
      const internalid = result.getValue({ name: 'internalid' });
      const taxOnPurchase = result.getValue({ name: 'custitem_aehr_po_tax' });
      const expenseAccount = result.getValue({ name: 'expenseaccount' });
      if (taxOnPurchase) {
        itemData[internalid] = {
          taxOnPurchase,
          expenseAccount
        };
      }

      return true;
    });

    return itemData;
  }

  return {
    afterSubmit
  };
});
