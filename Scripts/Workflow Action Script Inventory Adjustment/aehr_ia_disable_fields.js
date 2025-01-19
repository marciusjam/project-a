/**
 * @NApiVersion 2.1
 * @NScriptType ClientScript
 */

define(['N/currentRecord'], (currentRecord) => {
    function disableLineFields(context) {
        try {
            var curRec = context.currentRecord;

            var sublistId = context.sublistId;

            console.log('sublistId', sublistId);

            if (sublistId !== 'inventory') return;

            var selectedLine = curRec.getCurrentSublistIndex({
                sublistId: sublistId

            });

            console.log('selectedLine', JSON.stringify(selectedLine));


            var fieldAdjustQty = curRec.getSublistField({
                sublistId: sublistId,
                fieldId: 'adjustqtyby',
                line: selectedLine
            });

            var fieldUnitCost = curRec.getSublistField({
                sublistId: sublistId,
                fieldId: 'unitcost',
                line: selectedLine
            });

            var fieldInventoryDetail = curRec.getSublistField({
                sublistId: sublistId,
                fieldId: 'inventorydetail',
                line: selectedLine
            });


            fieldAdjustQty.isDisabled = true;
            fieldUnitCost.isDisabled = true;
            fieldInventoryDetail.isDisabled = true;




        } catch (error) {

            log.debug({ title: 'Catch Error', details: error });

        }

    }

    function fieldChanged(context) {
        var rec = context.currentRecord;

        try {
            // Check if the change happened on the desired sublist and field
            if (context.sublistId === 'inventory' && context.fieldId === 'custcol_proposed_quantity') {
                // Get the new value of 'custcol_proposed_quantity'
                var proposedQuantity = rec.getCurrentSublistValue({
                    sublistId: 'inventory',
                    fieldId: 'custcol_proposed_quantity'
                });

                console.log('proposedQuantity', JSON.stringify(proposedQuantity));

                // Set the 'adjQtyBy' field with the same value or a calculated value
                rec.setCurrentSublistValue({
                    sublistId: 'inventory',
                    fieldId: 'adjustqtyby',
                    value: 0, // Adjust the logic here if you want a different calculation
                    ignoreFieldChange: true // Avoid recursive triggers
                });
            }

            // Check if the change happened on the desired sublist and field
            if (context.sublistId === 'inventory' && context.fieldId === 'custcol_proposed_rate') {
                // Get the new value of 'custcol_proposed_rate'
                var proposedRate = rec.getCurrentSublistValue({
                    sublistId: 'inventory',
                    fieldId: 'custcol_proposed_rate'
                });

                console.log('proposedRate', JSON.stringify(proposedRate));

                // Set the 'adjQtyBy' field with the same value or a calculated value
                rec.setCurrentSublistValue({
                    sublistId: 'inventory',
                    fieldId: 'unitcost',
                    value: 0, // Adjust the logic here if you want a different calculation
                    ignoreFieldChange: true // Avoid recursive triggers
                });
            }

            var sublistName = rec.getSublist({ sublistId: "inventory" });
            var fieldAdjustQty = sublistName.getColumn({ fieldId: "adjustqtyby" });
            var fieldUnitCost = sublistName.getColumn({ fieldId: "unitcost" });
            var fieldInventoryDetail = sublistName.getColumn({ fieldId: "inventorydetail" });


            fieldAdjustQty.isDisabled = true;
            fieldUnitCost.isDisabled = true;
            fieldInventoryDetail.isDisabled = true;
            
        } catch (e) {
            console.error('Error in fieldChanged:', e.message);
        }
    }





    return {
        lineInit: disableLineFields,
        fieldChanged: fieldChanged
    };
}); 