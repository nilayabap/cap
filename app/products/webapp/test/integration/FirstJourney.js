sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheProductList.iSeeThisPage();
            Then.onTheProductList.onTable().iCheckColumns(5, {"ID":{"header":"ID"},"name":{"header":"name"},"stock":{"header":"stock"},"price":{"header":"price"},"category":{"header":"category"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheProductList.onFilterBar().iExecuteSearch();
            
            Then.onTheProductList.onTable().iCheckRows();

            When.onTheProductList.onTable().iPressRow(0);
            Then.onTheProductObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});