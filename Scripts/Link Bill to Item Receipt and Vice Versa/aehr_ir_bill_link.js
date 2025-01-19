/**
 * @NApiVersion 2.1
 * @NScriptType UserEventScript
 * Task          Date                Author                                         Remarks
 * Create        Nov 29 2024         John Marcius Tolentino   
*/
define(['N/record'],

    function (record) {


        function beforeLoad(context) { }

        function afterSubmit(context) {
            try {
                if (context.type == context.UserEventType.CREATE) {
                    var vbRecord = context.newRecord;
                    let transformFrom = vbRecord.getValue('transform');
                    let itemReceiptID = vbRecord.getValue('custbody_linked_ir');
                    let billID = vbRecord.id;

                    log.debug('afterSubmit - billID',billID)
                    log.debug('afterSubmit - itemReceiptID',itemReceiptID)
    
                    if (transformFrom == 'purchord' && itemReceiptID) {
                        try {
                            var itemReceiptRecord = record.load({
                                type: record.Type.ITEM_RECEIPT, 
                                id: itemReceiptID,
                                isDynamic: true,
                            });;
                            itemReceiptRecord.setValue('custbody_linked_vb',billID);
                            var recordid = itemReceiptRecord.save();
                            log.debug('Bill Linked to IR', itemReceiptID)
                        } catch (error) {
                            log.error('Could not link Bill to IR ' + itemReceiptID, error.message)
                        }
                        
                        
                    }
                }
            } catch (error) {
                log.error('ERROR',error.message)
            }
            
        }

        function beforeSubmit(context) {
            try {
                if (context.type == context.UserEventType.CREATE) {
                    var vbRecord = context.newRecord;
                    let transformFrom = vbRecord.getValue('transform');
                    let itemReceiptID = vbRecord.getValue('itemrcpt');

                    log.debug('beforeSubmit - vbRecord',vbRecord.id)
                    log.debug('beforeSubmit - transformFrom',transformFrom)
                    log.debug('beforeSubmit - itemReceiptID',itemReceiptID)
    
                    if (transformFrom == 'purchord' && itemReceiptID) {
                        vbRecord.setValue('custbody_linked_ir', itemReceiptID);
                    }
                }
            } catch (error) {
                log.error('ERROR',error.message)
            }
            
        }

        return {
            beforeLoad: beforeLoad,
            afterSubmit: afterSubmit,
            beforeSubmit: beforeSubmit
        }
    }
)