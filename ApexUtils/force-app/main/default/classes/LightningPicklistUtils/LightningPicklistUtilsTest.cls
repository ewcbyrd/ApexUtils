@IsTest
private class LightningPicklistUtilsTest {
    
    @IsTest
    private static void getOptionsForComponentTest() {
        LightningPicklistUtils.OptionsWrapper ow1 = new LightningPicklistUtils.OptionsWrapper('Account', 'AccountSource');
        LightningPicklistUtils.OptionsWrapper ow2 = new LightningPicklistUtils.OptionsWrapper('Account', 'Industry');
        List<LightningPicklistUtils.OptionsWrapper> owList = new List<LightningPicklistUtils.OptionsWrapper>{ow1, ow2};
        String payload = JSON.serialize(owList);
        Test.startTest();
        String results = LightningPicklistUtils.getOptionsForComponent(payload);
        Test.stopTest();
        Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(results);
        System.assertEquals(2, resultMap.size());
    }

}
