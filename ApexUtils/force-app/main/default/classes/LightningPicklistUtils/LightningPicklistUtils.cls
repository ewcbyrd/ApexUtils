public with sharing class LightningPicklistUtils {
    
    @AuraEnabled
    public static String getOptionsForComponent(String payload) {
        List<OptionsWrapper> optionList = (List<OptionsWrapper>) JSON.deserialize(payload, List<OptionsWrapper>.class);
        Map<String, List<PicklistWrapper>> optionMap = new Map<String, List<PicklistWrapper>>();
        Map<String, Schema.SObjectType> sObjectTypeMap = Schema.getGlobalDescribe();
        for (OptionsWrapper ow : optionList) {
            String key = ow.obj + '-' + ow.field;
            List<Schema.PicklistEntry> pleList = sObjectTypeMap
                .get(ow.obj)
                .getDescribe()
                .fields.getMap()
                .get(ow.field)
                .getDescribe()
                .getPicklistValues();
            for (Schema.PicklistEntry ple : pleList) {
                if (!optionMap.containsKey(key)) {
                    optionMap.put(key, new List<PicklistWrapper>());
                }
                optionMap.get(key).add(new PicklistWrapper(ple));
            }
        }
        return JSON.serialize(optionMap);
    }

    public class PicklistWrapper {
        @AuraEnabled
        public string label {get;set;}

        @AuraEnabled
        public string value {get;set;}

        public PicklistWrapper(Schema.PicklistEntry ple) {
            this.label = ple.getLabel();
            this.value = ple.getValue();
        }
    }

    public class OptionsWrapper {
        public String obj {get; set;}
        public String field {get; set;}

        public OptionsWrapper(String obj, String field) {
            this.obj = obj;
            this.field = field;
        }
    }
}
