//** Created by Guyon Joris, INSERM u1029,
//   Bordeaux University, Pessac, Gironde, December 09, 2020
//
// This macro was created to faciliate the analysis of spheroid on Fiji.

/* Based on Guyon, J., Andrique, L., Pujol, N., Røsland, G. V., Recher, G., Bikfalvi, A., Daubon, T. 
 * A 3D Spheroid Model for Glioblastoma. J. Vis. Exp. (158), e60998, doi:10.3791/60998 (2020).
 */

/*
 * version 2.0, December 09, 2020
 */

// Adjustable Variables
var core_quantification = true ;
var total_quantification = true ;
var a_substraction = false ;
var unsharp_radius = 5 ;
var unsharp_weight = 0.6 ;
var med_filter_radius = 5 ;
var background_radius = 5 ;
var min_size = 15000 ;
var name ;

var URL = "https://github.com/Guyon-J/Macro_for_Spheroid_Analysis" ;


/*********************************************************************************************************************
 **********************************************************************************************************************/

// Action tools and options
macro "HELP Action Tool - Cf00D15D16D17D18D19D27D35D36D37D38D39D55D56D57D58D59D65D67D69D75D79D95D96D97D98D99Da9Dc5Dc6Dc7Dc8Dc9Dd5Dd7De5De6De7CbffD00D01D0cD23D4dD4fD5fD63D7bD82D9bDacDc2Dd0DefDf3DfdDffCff8D0bD1bD1dD1fD20D32D33D3cD4bD51D53D7eD8cD8dD90D9cD9fDbdDcdDcfDe2DecDfbCfffD04D05D06D07D08D09D0aD14D1aD24D25D26D28D29D2aD34D3aD44D45D46D47D48D49D4aD54D5aD64D66D68D6aD74D76D77D78D7aD84D85D86D87D88D89D8aD94D9aDa4Da5Da6Da7Da8DaaDb4Db5Db6Db7Db8Db9DbaDc4DcaDd4Dd6Dd8Dd9DdaDe4De8De9DeaDf4Df5Df6Df7Df8Df9DfaCcccD03D0eD22D2dD50D6bD6eD80D8fDafDb1DbeDbfDdbDe0De3Df2DfeCfffD2cD3bD9dDa3Db3DbcDc1CeeeD0dD12D1cD2bD3dD42D43D4cD5cD5dD6cD72D73D7cD7dD83D92D93D9eDa1Da2DadDb2Dc3DccDceDd1Dd3DedC666D8bCdddD02D13D2eD2fD3eD40D41D4eD52D5eD62D6dD70D71D7fD81D8eD91Da0DaeDc0Dd2DdcDddDdeDdfDebCbbbD21D31D3fD61D6fDb0DeeDf1DfcC999DbbC888D0fD30D5bDabCaaaD10D11D1eD60De1C777DcbDf0"{
	run("URL...", "url="+URL);
}

macro "HELP Action Tool Options" {
	// empty
}

/*********************************************************************************************************************
 **********************************************************************************************************************/
macro "Spheroid Action Tool - C000D15D16D1aD24D27D2aD34D37D3aD44D48D49D64D65D66D67D68D69D6aD74D77D84D87D95D96Db4Db5Db6Db7Db8Db9DbaDc7Dd7De4De5De6De7De8De9DeaC0aeD00D0eD11D1fD20D22D2dD3dD7eD82D8fD9eDaeDc0Dc2DcdDeeDf2DfdCeebD01D0cD0fD12D1cD1eD21D2cD30D3cD3eD41D42D4cD4eD4fD51D52D5cD5dD5eD60D61D6cD6eD72D7cD7dD7fD80D81D8cD90D92D9cD9dDa1Da2DacDafDb0Db2DbcDbeDccDd1DdcDddDdeDe1De2DecDfcDffCfffD03D04D05D06D07D08D09D0aD0bD13D14D17D18D19D1bD23D25D26D28D29D2bD33D35D36D38D39D3bD43D45D46D47D4aD4bD53D54D55D56D57D58D59D5aD5bD63D6bD73D75D76D78D79D7aD7bD83D85D86D88D89D8aD8bD93D94D97D98D99D9aD9bDa3Da4Da5Da6Da7Da8Da9DaaDabDb3DbbDc3Dc4Dc5Dc6Dc8Dc9DcaDcbDd3Dd4Dd5Dd6Dd8Dd9DdaDdbDe3DebDf3Df4Df5Df6Df7Df8Df9DfaDfbC2b4D0dD2fD32D3fD40D5fD62D70D8dD9fDa0Db1DbdDceDcfDd0Dd2DefDfeCcccDf0Cbe1D02D10D1dD2eD31D4dD50D6dD6fD71D8eD91DadDbfDc1DdfDe0DedDf1"{
	roiManager("deselect"); 
	roiManager("Show None"); 
	ni = nImages ;
	for (i = 0; i < ni; i++) {
		name = getTitle();
		if (core_quantification == true) {
			Core_Area();
		}
		if (total_quantification==true) {
			Total_Area();
		}
		if (a_substraction==true) {
			Substraction();
		}
		run("Put Behind [tab]");
	}	
	run("Cascade");
}

macro "Spheroid Action Tool Options" {
	Dialog.create("Spheroid Analysis Options");
	Dialog.addMessage("Areas selection");
	Dialog.addCheckbox("Core", core_quantification);
	Dialog.addCheckbox("Total", total_quantification);
	Dialog.addCheckbox("Automatic substraction", a_substraction);
	Dialog.addMessage("____________________________");
	Dialog.addMessage("Parameters for Total");
	Dialog.addMessage(" ");
	Dialog.addNumber("Background radius", background_radius);
	Dialog.addNumber("Median filter radius", med_filter_radius);
	Dialog.addMessage("____________________________");
	Dialog.addMessage("Parameters for Core");
	Dialog.addMessage(" ");
	Dialog.addNumber("Unsharp Mask Radius", unsharp_radius);
	Dialog.addNumber("Unsharp Mask Weight", unsharp_weight);
	Dialog.addNumber("Min weight for sifting", min_size);
	Dialog.show();
	core_quantification = Dialog.getCheckbox();
	total_quantification = Dialog.getCheckbox();
	a_substraction = Dialog.getCheckbox();
	unsharp_radius = Dialog.getNumber(); 
	unsharp_weight = Dialog.getNumber();
	med_filter_radius = Dialog.getNumber(); 
	background_radius = Dialog.getNumber(); 
	min_size = Dialog.getNumber(); 
}

macro "Total Area Action Tool - C000D05D15D16D17D18D19D25D36D37D38D45D49D55D59D66D67D68D75D85D86D87D88D89D95Da6Da7Da8Da9Db5Db7Dc6Dc7Dc8Dc9De5De6De7De8De9Df9C0aeD00D0eD11D1fD20D22D2dD3dD7eD82D8fD9eDaeDc0Dc2DcdDeeDf2DfdCeebD01D0cD0fD12D1cD1eD21D2cD30D3cD3eD41D42D4cD4eD4fD51D52D5cD5dD5eD60D61D6cD6eD72D7cD7dD7fD80D81D8cD90D92D9cD9dDa1Da2DacDafDb0Db2DbcDbeDccDd1DdcDddDdeDe1De2DecDfcDffCfffD03D04D06D07D08D09D0aD0bD13D14D1aD1bD23D24D26D27D28D29D2aD2bD33D34D35D39D3aD3bD43D44D46D47D48D4aD4bD53D54D56D57D58D5aD5bD63D64D65D69D6aD6bD73D74D76D77D78D79D7aD7bD83D84D8aD8bD93D94D96D97D98D99D9aD9bDa3Da4Da5DaaDabDb3Db4Db6Db8Db9DbaDbbDc3Dc4Dc5DcaDcbDd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDdbDe3De4DeaDebDf3Df4Df5Df6Df7Df8DfaDfbC2b4D0dD2fD32D3fD40D5fD62D70D8dD9fDa0Db1DbdDceDcfDd0Dd2DefDfeCcccDf0Cbe1D02D10D1dD2eD31D4dD50D6dD6fD71D8eD91DadDbfDc1DdfDe0DedDf1"{
	name = getTitle();
	Total_Area()
}

macro "Total Area Action Tool Options" {
	Dialog.create("Total Area parameters");
	Dialog.addNumber("Background radius", background_radius);
	Dialog.addNumber("Median filter radius", med_filter_radius);
	Dialog.show();
	med_filter_radius = Dialog.getNumber(); 
	background_radius = Dialog.getNumber(); 
}


macro "Core Area Action Tool - C000D16D17D18D25D29D35D39D56D57D58D65D69D76D77D78D96D97D98D99Da5Da7Da8Db6Db7Db9Dd5Dd6Dd7Dd8Dd9De5De7De9CfffD03D04D05D06D07D08D09D0aD0bD13D14D15D19D1aD1bD23D24D26D27D28D2aD2bD33D34D36D37D38D3aD3bD43D44D45D46D47D48D49D4aD4bD53D54D55D59D5aD5bD63D64D66D67D68D6aD6bD73D74D75D79D7aD7bD83D84D85D86D87D88D89D8aD8bD93D94D95D9aD9bDa3Da4Da6Da9DaaDabDb3Db4Db5Db8DbaDbbDc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDcbDd3Dd4DdaDdbDe3De4De6De8DeaDebDf3Df4Df5Df6Df7Df8Df9DfaDfbC0aeD00D0eD11D1fD20D22D2dD3dD7eD82D8fD9eDaeDc0Dc2DcdDeeDf2DfdCeebD01D0cD0fD12D1cD1eD21D2cD30D3cD3eD41D42D4cD4eD4fD51D52D5cD5dD5eD60D61D6cD6eD72D7cD7dD7fD80D81D8cD90D92D9cD9dDa1Da2DacDafDb0Db2DbcDbeDccDd1DdcDddDdeDe1De2DecDfcDffCcccDf0Cbe1D02D10D1dD2eD31D4dD50D6dD6fD71D8eD91DadDbfDc1DdfDe0DedDf1C2b4D0dD2fD32D3fD40D5fD62D70D8dD9fDa0Db1DbdDceDcfDd0Dd2DefDfe"{
	name = getTitle();
	Core_Area()
}

macro "Core Area Action Tool Options" {
	Dialog.create("Core Area parameters");
	Dialog.addNumber("Unsharp Mask Radius", unsharp_radius);
	Dialog.addNumber("Unsharp Mask Weight", unsharp_weight);
	Dialog.addNumber("Min weight for sifting", min_size);
	Dialog.show();

	unsharp_radius = Dialog.getNumber(); 
	unsharp_weight = Dialog.getNumber();
	min_size = Dialog.getNumber(); 
}

/*********************************************************************************************************************
 **********************************************************************************************************************/

//Functions
function Total_Area(){
	run("Duplicate...", " "); 
	run("Brightness/Contrast..."); 
	run("Enhance Contrast", "saturated=0.35"); 
	run("Apply LUT"); 
	run("Subtract Background...", "rolling="+background_radius+" light disable"); 
	setOption("BlackBackground", false); 
	run("Make Binary"); 
	run("Dilate"); 
	run("Close-"); 
	run("Median...", "radius="+med_filter_radius); 
	run("Fill Holes");
	run("Create Selection"); 
	roiManager("Add");
	nROI = roiManager("count")-1;
	roiManager("Select", nROI);
	roiManager("rename", "Total_Area_"+name);
	roiManager("deselect");
	roiManager("Show None") 
	close();
}

function Core_Area(){ 
	run("Duplicate...", " "); 
	run("Enhance Contrast", "saturated=0.35"); 
	run("Apply LUT"); 
	run("Subtract Background...", "rolling=2 light create"); 
	run("Min...", "value=1000"); 
	run("Median...", "radius="+med_filter_radius); 
	run("Unsharp Mask...", "radius="+unsharp_radius+" mask="+unsharp_weight); 
	run("Subtract Background...", "rolling=5 light create disable"); 
	run("Make Binary"); 
	run("Dilate"); 
	run("Dilate"); 
	run("Close-"); 
	run("Fill Holes"); 
	run("Erode"); 
	run("Erode"); 
	run("Median...", "radius=50"); 
	run("Analyze Particles...", "size="+min_size+"-Infinity circularity=0.80-1.00 show=Masks exclude in_situ");
	run("Create Selection"); 
	roiManager("Add");
	nROI = roiManager("count")-1;
	roiManager("Select", nROI);
	roiManager("rename", "Core_Area_"+name);
	roiManager("deselect");
	roiManager("Show None"); 
	close();
}

function Substraction(){ 
	number = (roiManager("count")-2);
	roiManager("Select", number); 
	roiManager("Select", newArray(number,number+1)); 
	roiManager("XOR"); 
	roiManager("Add"); 
	roiManager("select", number+2); 
	roiManager("rename", "Invasive_Area_"+name); 
	roiManager("deselect"); 
	roiManager("Show None"); 
}