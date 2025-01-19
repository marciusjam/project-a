/**
 * @NApiVersion 2.1
 */

function onAction (scriptContext) {
    const newRecord = scriptContext.newRecord;
    const myScript = runtime.getCurrentScript();
    const scriptParamSalesRep = myScript.getParameter({
      name: 'custscript_salesrep'
    });
    newRecord.getLineCount();
    var items = newRecord.getSublist('item')
    for (let index = 0; index < array.length; index++) {
        const items = array[index];
        items[index].proposedQuantity = quantity;
        items[index].proposedRate = rate;
        items[index].proposedBins = bins;
        
    }
    newRecord.setValue({
      fieldId: 'salesrep',
      value: scriptParamSalesRep
    });
  } 
  
            