Map.centerObject(Nairobi,11)
var maxAoiArea = 8e11;
var aoiArea = null;

var palette = ['#0c0937','#0f1876', '#1865d4', '#10cdd4', '#0ed476', '#24d40d', '#e8df19', '#ff5c21','#ff3207'];

var dataInfo = {
  'Nitrogen dioxide': {
    'Near-real-time': 'COPERNICUS/S5P/NRTI/L3_NO2',
    Offline: 'COPERNICUS/S5P/OFFL/L3_NO2',
    colId: 'COPERNICUS/S5P/NRTI/L3_NO2',
    band: 'tropospheric_NO2_column_number_density',
    cloudBand: 'cloud_fraction',
    maskVal: 0.00007,
    scalar: 1e6,
    clipToCollection: Nairobi,
    legendLabel: 'NO2 (μmol/m²)',
    unitsLabel: 'NO₂ (μmol/m²)',
    visParams: {
      palette: palette,
      min: 20.0,
      max: 400.0,
    },
    viewWindow: {
      min: 0.0,
      max: 1000.0
    },
    baseline: 0
  },
  // 'Aerosol': {
  //   'Near-real-time': 'COPERNICUS/S5P/NRTI/L3_AER_AI',
  //   Offline: 'COPERNICUS/S5P/OFFL/L3_AER_AI',
  //   colId: 'COPERNICUS/S5P/NRTI/L3_AER_AI',
  //   band: 'absorbing_aerosol_index',
  //   cloudBand: '',
  //   maskVal: -1,
  //   scalar: 1,
  //   legendLabel: 'UV Aerosol Index',
  //   unitsLabel: 'UV Aerosol Index',
  //   visParams: {
  //     palette: palette,
  //     min: -1,
  //     max: 2,
  //   },
  //   viewWindow: {
  //     min: -1.5,
  //     max: 2.5
  //   },
  //   baseline: 0
  // },
  'Carbon monoxide': {
    'Near-real-time': 'COPERNICUS/S5P/NRTI/L3_CO',
    Offline: 'COPERNICUS/S5P/OFFL/L3_CO',
    colId: 'COPERNICUS/S5P/NRTI/L3_CO',
    band: 'CO_column_number_density',
    cloudBand: '',
    maskVal: 0,
    scalar: 1,
    legendLabel: 'CO (mol/m²)',
    unitsLabel: 'CO (mol/m²)',
    visParams: {
      palette: palette,
      min: 0.0,
      max: 0.05,
    },
    viewWindow: {
      min: 0.0,
      max: 0.1
    },
    baseline: 0
  },
  'Formaldehyde': {
    'Near-real-time': 'COPERNICUS/S5P/NRTI/L3_HCHO',
    Offline: 'COPERNICUS/S5P/OFFL/L3_HCHO',
    colId: 'COPERNICUS/S5P/NRTI/L3_HCHO',
    band: 'tropospheric_HCHO_column_number_density',
    cloudBand: 'cloud_fraction',
    maskVal: 0,
    scalar: 1e6,
    legendLabel: 'HCHO (μmol/m²)',
    unitsLabel: 'HCHO (μmol/m²)',
    visParams: {
      palette: palette,
      min: 0.0,
      max: 300.0,
    },
    viewWindow: {
      min: 0.0,
      max: 600.0
    },
    baseline: 0
  },
  // 'Ozone': {
  //   'Near-real-time': 'COPERNICUS/S5P/NRTI/L3_O3',
  //   Offline: 'COPERNICUS/S5P/OFFL/L3_O3',
  //   colId: 'COPERNICUS/S5P/NRTI/L3_O3',
  //   band: 'O3_column_number_density',
  //   cloudBand: 'cloud_fraction',
  //   maskVal: 0.12,
  //   scalar: 1,
  //   legendLabel: 'O3 (mol/m²)',
  //   unitsLabel: 'O3 (mol/m²)',
  //   visParams: {
  //     palette: palette,
  //     min: 0.1,
  //     max: 0.16,
  //   },
  //   viewWindow: {
  //     min: 0.0,
  //     max: 0.2
  //   },
  //   baseline: 0.1
  // },
  // 'Sulphur Dioxide': {
  //   'Near-real-time': 'COPERNICUS/S5P/NRTI/L3_SO2',
  //   Offline: 'COPERNICUS/S5P/OFFL/L3_SO2',
  //   colId: 'COPERNICUS/S5P/NRTI/L3_SO2',
  //   band: 'SO2_column_number_density',
  //   cloudBand: 'cloud_fraction',
  //   maskVal: 0,
  //   scalar: 1e6,
  //   legendLabel: 'SO2 (μmol/m²)',
  //   unitsLabel: 'SO₂ (μmol/m²)',
  //   visParams: {
  //     palette: palette,
  //     min: 0.0,
  //     max: 1000.0,
  //   },
  //   viewWindow: {
  //     min: 0.0,
  //     max: 4000.0
  //   },
  //   baseline: 0
  // },
  // 'Methane': {
  //   'Near-real-time': 'COPERNICUS/S5P/OFFL/L3_CH4',
  //   Offline: 'COPERNICUS/S5P/OFFL/L3_CH4',
  //   colId: 'COPERNICUS/S5P/OFFL/L3_CH4',
  //   band: 'CH4_column_volume_mixing_ratio_dry_air',
  //   cloudBand: '',
  //   maskVal: 1750,
  //   scalar: 1,
  //   legendLabel: 'ppmV',
  //   unitsLabel: 'ppmV',
  //   visParams: {
  //     palette: palette,
  //     min: 1800.0,
  //     max: 1900.0,
  //   },
  //   viewWindow: {
  //     min: 1600.0,
  //     max: 2000.0
  //   },
  //   baseline: 1800
  // }
};

var dateInfo = {
  left: {selected: ''},
  right: {selected: ''}
};

var dataSelector = ui.Select({
  items: Object.keys(dataInfo)
});

var colSelector = ui.Select({
  items: ['Near-real-time', 'Offline']
});

var datasetUrl = ui.url.get('dataset', 'Nitrogen dioxide');
ui.url.set('dataset', datasetUrl);
var thisData = dataInfo[datasetUrl];
dataSelector.set({placeholder: datasetUrl, value: datasetUrl});

var dataTypeUrl = ui.url.get('datatype', 'Near-real-time');
ui.url.set('datatype', dataTypeUrl);
thisData.colId = thisData[dataTypeUrl];
colSelector.set({placeholder: dataTypeUrl, value: dataTypeUrl});

var initPoint = ee.Geometry.Point(36.8219, -1.29).toGeoJSONString();
var center = ui.url.get('center', initPoint);
ui.url.set('center', center);
var zoom = ui.url.get('zoom', '11');
ui.url.set('center', zoom);

var aoiUrl = ui.url.get('aoi', initPoint);
var aoi = ee.Geometry(JSON.parse(aoiUrl));
ui.url.set('aoi', aoi.toGeoJSONString());

var cloudPct = ui.url.get('cloud', 10);
ui.url.set('cloud', cloudPct);
var cloudFrac = cloudPct/100;

var leftSliderDateUrl = ui.url.get('leftdate', '2020-01-01');
ui.url.set('leftdate', leftSliderDateUrl);

var rightSliderDateUrl = ui.url.get('rightdate', '2020-02-01');
ui.url.set('rightdate', rightSliderDateUrl);

dateInfo.left.selected = leftSliderDateUrl;
dateInfo.right.selected = rightSliderDateUrl;
var minStretchVal = ui.url.get('min', 20);
ui.url.set('min', minStretchVal);

thisData.visParams.min = minStretchVal;
var maxStretchVal = ui.url.get('max', 400);
ui.url.set('max', maxStretchVal);
thisData.visParams.max = maxStretchVal;

function getMinMaxDate() {
  var col = ee.ImageCollection(thisData.colId)
    .filterBounds(aoi);
  var dataDateRange = ee.Dictionary(col.reduceColumns(
    {reducer: ee.Reducer.minMax(), selectors: ['system:time_start']}));
  var firstDate = ee.Date(dataDateRange.get('min'));
  var lastDate = ee.Date(dataDateRange.get('max'));
  return ee.Dictionary({firstDate: firstDate, lastDate: lastDate});
}
function leftDateHandler() {
  leftLabel.style().set({shown: false});
  var selectedDate = ee.Date(ee.List(leftDatePanel.widgets().get(1).getValue()).get(0));
  selectedDate.format('YYYY-MM-dd').evaluate(function(date) {
    ui.url.set('leftdate', date);
    dateInfo.left.selected = date;
    var img = compositeImages(selectedDate);
    leftMap.layers().set(0, ui.Map.Layer(img, thisData.visParams, null, true, 0.55));
    leftLabel.setValue(date);
    leftLabel.style().set({shown: true});
    drawChart();
  });
}
function rightDateHandler() {
  rightLabel.style().set({shown: false});
  var selectedDate = ee.Date(ee.List(rightDatePanel.widgets().get(1).getValue()).get(0));
  selectedDate.format('YYYY-MM-dd').evaluate(function(date) {
    ui.url.set('rightdate', date);
    dateInfo.right.selected = date;
    var img = compositeImages(selectedDate);
    rightMap.layers().set(0, ui.Map.Layer(img, thisData.visParams, null, true, 0.55));
    rightLabel.setValue(date);
    rightLabel.style().set({shown: true});
    drawChart();
  });
}
// ### LETS  STEP UP THE INFO PANEL ###
var infoPanel = ui.Panel({style: {width: '400px'}});

var intro = ui.Panel([
  ui.Label({
    value: 'Nairobi Air Quality Monitor',
    style: {fontSize: '24px', fontWeight: 'bold'}
  }),
  // ui.Label('An interactive platform for visualizing time series data of air pollutants in Nairobi County.')
]);

var leftSliderDate = ui.DateSlider({
  start: '2020-01-01',
  end: '2020-02-01',
  value: '2020-01-15',
  period: 1,
  style: {stretch: 'horizontal', shown: true}});
leftSliderDate.setDisabled(true);

var rightSliderDate = ui.DateSlider({
  start: '2020-01-01',
  end: '2020-02-01',
  value: '2020-01-15',
  period: 1,
  style: {stretch: 'horizontal', shown: true}});
rightSliderDate.setDisabled(true);

var dataSelectPanel = ui.Panel({
  widgets: [dataSelector, colSelector],
  layout: ui.Panel.Layout.flow('horizontal'), style: {stretch: 'horizontal'}
});
var dateSliderLabelWidth = '45px';
var cloudFracSlider = ui.Slider({min: 0, max: 100, value: cloudPct, step: 1, style: {stretch: 'horizontal'}});
cloudFracSlider.setDisabled(true);

var leftDateLabel = ui.Label({value: 'LEFT:', style: {width: dateSliderLabelWidth, color: '000', fontWeight: 'bold', padding: '25px 0px 0px 0px'}});
var leftDatePanel = ui.Panel({
  widgets: [leftDateLabel, leftSliderDate],
  layout: ui.Panel.Layout.flow('horizontal'),
  style: {stretch: 'horizontal'}
});
var rightDateLabel = ui.Label({value: 'RIGHT:', style: {width: dateSliderLabelWidth, color: '000', fontWeight: 'bold', padding: '25px 0px 0px 0px'}});

var rightDatePanel = ui.Panel({
  widgets: [rightDateLabel, rightSliderDate],
  layout: ui.Panel.Layout.flow('horizontal'),
  style: {stretch: 'horizontal'}
});
var minVis = ui.Slider({
  min: thisData.viewWindow.min+0.0,
  max: thisData.viewWindow.max+0.0,
  value: thisData.visParams.min+0.0,
  step: (thisData.viewWindow.max+0.0-thisData.viewWindow.min+0.0)/100,
  style: {stretch: 'horizontal'},
  onChange: updateStretch
});
var maxVis = ui.Slider({
  min: thisData.viewWindow.min+0.0,
  max: thisData.viewWindow.max+0.0,
  value: thisData.visParams.max+0.0,
  step: (thisData.viewWindow.max+0.0-thisData.viewWindow.min+0.0)/100,
  style: {stretch: 'horizontal'},
  onChange: updateStretch
});
var stretchPanel = ui.Panel({
  widgets: [ui.Label('Min:'), minVis, ui.Label('Max:'), maxVis],
  layout: ui.Panel.Layout.flow('horizontal'),
  style: {stretch: 'horizontal'}
});
var cloudFracIndex = 0;
var leftDateIndex = 0;
var rightDateIndex = 0;
var legendIndex = 10;
var swipeSwitchIndex = 11;

var mapComparison = ui.Panel([
  ui.Label({value: '1. Select an atmospheric concentration dataset:'}),
  dataSelectPanel,
  ui.Label({value: '2. Select Maximum cloud cover:'}),
  cloudFracSlider,
  ui.Label({value: '3. Select Map dates:'}),
  leftDatePanel,
  rightDatePanel,
  ui.Label({value: '4. Adjust palette stretch:'}),
  stretchPanel, 
]);
infoPanel.add(intro);
var panelBreak25 = ui.Panel(null, null, {stretch: 'horizontal', height: '1px', backgroundColor: 'white', margin: '8px 0px 8px 0px'});
infoPanel.add(panelBreak25);
infoPanel.add(mapComparison);

function dataSelectorHandler(e) {
  var datasetFromClick = dataSelector.getValue();
  var dataTypeFromClick = colSelector.getValue();
  ui.url.set('dataset', datasetFromClick);
  ui.url.set('datatype', dataTypeFromClick);
  thisData = dataInfo[datasetFromClick];
  thisData.colId = thisData[dataTypeFromClick];
  if(thisData.cloudBand !== '') {
    cloudFracSlider.setDisabled(false);
  } else {
    cloudFracSlider.setDisabled(true);
  }
  var minVis = ui.Slider({
    min: thisData.viewWindow.min+0.0,
    max: thisData.viewWindow.max+0.0,
    value: thisData.visParams.min+0.0,
    step: (thisData.viewWindow.max+0.0-thisData.viewWindow.min+0.0)/100,
    style: {stretch: 'horizontal'},
    onChange: updateStretch
  });
  var maxVis = ui.Slider({
    min: thisData.viewWindow.min+0.0,
    max: thisData.viewWindow.max+0.0,
    value: thisData.visParams.max+0.0,
    step: (thisData.viewWindow.max+0.0-thisData.viewWindow.min+0.0)/100,
    style: {stretch: 'horizontal'},
    onChange: updateStretch
  });
  stretchPanel.widgets().set(1, minVis);
  stretchPanel.widgets().set(3, maxVis);
  thisData.visParams.min = stretchPanel.widgets().get(1).getValue();
  thisData.visParams.max = stretchPanel.widgets().get(3).getValue();
  ui.url.set('min', thisData.visParams.min);
  ui.url.set('max', thisData.visParams.max);
  updateLeftSliderDate();
  updateRightSliderDate();
  makeLegend();
  aoi.area(1000).evaluate(function(area) {
    aoiArea = area;
    if(area > maxAoiArea){
      print('Drawn geometry is too large.');
      tsChart.widgets().get(0).style().set({shown: true});
      tsChart.widgets().get(1).style().set({shown: false});
      tsChart.widgets().get(2).style().set({shown: false});
      return;
    } else {
      tsChart.widgets().get(0).style().set({shown: false});
      setChart();
      chartTimeSeries();
    }
  });
}
dataSelector.onChange(dataSelectorHandler);
colSelector.onChange(dataSelectorHandler);

// ### LETS INITIALIZE THE NO2 
function maskClouds(img) {
  var cloudMask = img.select(thisData.cloudBand).lte(cloudFrac);
  return img.updateMask(cloudMask);
}
function compositeImages(targetDate) {
  var startDate = targetDate.advance(-4, 'day');
  var endDate = targetDate.advance(5, 'day');
  var dateFilter = ee.Filter.date(startDate, endDate);
  var col = ee.ImageCollection(thisData.colId).filter(dateFilter);
  if(thisData.cloudBand !== '') {
    col = col.map(maskClouds);
  }
  return col.select(thisData.band).reduce(ee.Reducer.mean()).multiply(thisData.scalar).clip(Nairobi);
}

// ###LETS  STEP UP THE MAP CANVASES ###
var leftLabel = ui.Label('[leftLabel]',
  {shown: false, position: 'bottom-left', fontWeight: 'bold', color:'000',
  fontSize: '18px', backgroundColor: 'rgba(255, 255, 255, 1.0)'});
var rightLabel = ui.Label('[rightLabel]',
  {shown: false, position: 'bottom-right', fontWeight: 'bold', color:'000',
  fontSize: '18px', backgroundColor: 'rgba(255, 255, 255, 1.0)'}); 
var leftMap = ui.Map().centerObject(Nairobi, 10);
var rightMap = ui.Map().centerObject(Nairobi, 10);
leftMap.setControlVisibility({layerList: false, zoomControl: false, fullscreenControl: false});
rightMap.setControlVisibility({layerList: false, zoomControl: false, fullscreenControl: false});
leftMap.drawingTools().setShown(false);
rightMap.drawingTools().setShown(false);
var linker = ui.Map.Linker([leftMap, rightMap]);
var swipeStatus = ui.url.get('swipe', false);
ui.url.set('swipe', swipeStatus);
var sliderPanel = ui.SplitPanel({
  firstPanel: linker.get(0),
  secondPanel: linker.get(1),
  orientation: 'horizontal',
  wipe: swipeStatus,
  style: {stretch: 'both'}
});
var swipeButtonLabel = 'Split Map display';
if(swipeStatus) {
  swipeButtonLabel = 'Show side-by-side display';
}
var swipeButton = ui.Button(swipeButtonLabel, switchSwipe, null, {position: 'top-left', });
mapComparison.widgets().set(swipeSwitchIndex, swipeButton);
function switchSwipe() {
  if(swipeStatus) {
    sliderPanel.setWipe(false);
    swipeButton.setLabel('Split Map display');
    swipeStatus = false;
    ui.url.set('swipe', 'false');
  } else {
    sliderPanel.setWipe(true);
    swipeButton.setLabel('Show side-by-side display');
    swipeStatus = true;
    ui.url.set('swipe', 'true');
  }
}
function updateCloudFracSlider(val) {
  cloudPct = val;
  ui.url.set('cloud', val);
  cloudFrac = cloudPct/100;
  updateLeftSliderDate();
  updateRightSliderDate();
  aoi.area(1000).evaluate(function(area) {
    aoiArea = area;
    if(area > maxAoiArea){
      print('Drawn geometry is too large.');
      tsChart.widgets().get(0).style().set({shown: true});
      tsChart.widgets().get(1).style().set({shown: false});
      tsChart.widgets().get(2).style().set({shown: false});
      return;
    } else {
      tsChart.widgets().get(0).style().set({shown: false});
      setChart();
      chartTimeSeries();
    }
  });
}
cloudFracSlider.onChange(updateCloudFracSlider);
function updateLeftSliderDate() {
  leftDatePanel.widgets().get(1).setDisabled(true); 
  leftLabel.style().set({shown: false});
  var dateRange = getMinMaxDate();
  var firstDate = ee.Date(dateRange.get('firstDate'));
  var firstDateMillis = ee.Date(dateRange.get('firstDate')).millis();
  var lastDate = ee.Date(dateRange.get('lastDate'));
  var lastDateMillis = ee.Date(dateRange.get('lastDate')).millis();
  var selectedDate = ee.Date(dateInfo.left.selected);
  var selectedDateMillis = ee.Date(dateInfo.left.selected).millis();
  selectedDate = ee.Date(ee.Algorithms.If(
    firstDateMillis.gt(selectedDateMillis),
    firstDate,
    selectedDate
  ));
  selectedDate = ee.Date(ee.Algorithms.If(
    lastDateMillis.lt(selectedDateMillis),
    lastDate,
    selectedDate
  ));
  var img = compositeImages(selectedDate);
  leftMap.layers().set(0, ui.Map.Layer(img.clip(Nairobi), thisData.visParams, null, true, 0.55));
  ee.Dictionary({
    firstDate: firstDate.format('YYYY-MM-dd'),
    lastDate: lastDate.format('YYYY-MM-dd'),
    selectedDate: selectedDate.format('YYYY-MM-dd')
  })
  .evaluate(function(dates){
    var dateSelector = ui.DateSlider({
      start: dates.firstDate,
      end: dates.lastDate,
      value: dates.selectedDate,
      period: 1,
      style: {stretch: 'horizontal'},
      onChange: leftDateHandler
    });
    leftDatePanel.widgets().set(1, dateSelector);
    leftLabel.setValue(dates.selectedDate);
    leftLabel.style().set({shown: true});
    drawChart();
  });
}
function updateRightSliderDate() {
  rightDatePanel.widgets().get(1).setDisabled(true);
  rightLabel.style().set({shown: false});
  var dateRange = getMinMaxDate();
  var firstDate = ee.Date(dateRange.get('firstDate'));
  var firstDateMillis = ee.Date(dateRange.get('firstDate')).millis();
  var lastDate = ee.Date(dateRange.get('lastDate'));
  var lastDateMillis = ee.Date(dateRange.get('lastDate')).millis();
  var selectedDate = ee.Date(dateInfo.right.selected);
  var selectedDateMillis = ee.Date(dateInfo.right.selected).millis();
  selectedDate = ee.Date(ee.Algorithms.If(
    firstDateMillis.gt(selectedDateMillis),
    firstDate,
    selectedDate
  ));
  selectedDate = ee.Date(ee.Algorithms.If(
    lastDateMillis.lt(selectedDateMillis),
    lastDate,
    selectedDate
  ));
  var img = compositeImages(selectedDate);
  rightMap.layers().set(0, ui.Map.Layer(img.clip(Nairobi), thisData.visParams, null, true, 0.55));
  ee.Dictionary({
    firstDate: firstDate.format('YYYY-MM-dd'),
    lastDate: lastDate.format('YYYY-MM-dd'),
    selectedDate: selectedDate.format('YYYY-MM-dd')
  })
  .evaluate(function(dates){
    var dateSelector = ui.DateSlider({
      start: dates.firstDate,
      end: dates.lastDate,
      value: dates.selectedDate,
      period: 1,
      style: {stretch: 'horizontal'},
      onChange: rightDateHandler
    });
    rightDatePanel.widgets().set(1, dateSelector);
    rightLabel.setValue(dates.selectedDate);
    rightLabel.style().set({shown: true});
    drawChart();
  });
}
function updateStretch() {
  thisData.visParams.min = stretchPanel.widgets().get(1).getValue();
  thisData.visParams.max = stretchPanel.widgets().get(3).getValue();
  ui.url.set('min', thisData.visParams.min);
  ui.url.set('max', thisData.visParams.max);
  var leftImg = compositeImages(ee.Date(dateInfo.left.selected)).clip(Nairobi);
  var rightImg = compositeImages(ee.Date(dateInfo.right.selected)).clip(Nairobi);
  leftMap.layers().set(0, ui.Map.Layer(leftImg.clip(Nairobi), thisData.visParams, null, true, 0.55));
  rightMap.layers().set(0, ui.Map.Layer(rightImg.clip(Nairobi), thisData.visParams, null, true, 0.55));
  makeLegend();
}

// ### LETS SETUP THE CHARTS PANEL ###
var noPlotLabel = ui.Label({value: 'Drawn geometry is too large',
  style: {position: 'top-left', color: 'EE605E', fontWeight: 'bold', shown: false}});
var contChart = ui.Label({value: '', style: {position: 'top-left', shown: false}});
var yoyChart = ui.Label({value: '', style: {position: 'top-left', shown: false}});
var tsChart = ui.Panel([noPlotLabel, contChart, yoyChart]);

//  DEALING WITH GEOMETRY DRAWING ###
var drawingTools = leftMap.drawingTools();
var drawingToolsRight = rightMap.drawingTools();
while (drawingTools.layers().length() > 0) {
  var layer = drawingTools.layers().get(0);
  drawingTools.layers().remove(layer);
}

drawingTools.addLayer([aoi], null, 'FFF');
drawingToolsRight.addLayer([aoi], null, 'FFF');
drawingToolsRight.layers().get(0).setLocked(true);

// ### SETUP APP DISPLAY ###
var mapChartSplitPanel = ui.Panel(ui.SplitPanel({
  firstPanel: ui.Panel(sliderPanel, null, {height: '62%'}), //
  secondPanel: tsChart,
  orientation: 'vertical',
  wipe: false,
}));
var splitPanel = ui.SplitPanel(infoPanel, mapChartSplitPanel);
ui.root.widgets().reset([splitPanel]);
leftMap.onChangeBounds(function(e) {
  ui.url.set('center', ee.Geometry.Point(e.lon, e.lat).toGeoJSONString());
  ui.url.set('zoom', e.zoom);
});
leftMap.centerObject(ee.Geometry(JSON.parse(center)), parseInt(zoom));

// ### INITIALIZE MAP DATA ###
var blankImg = ee.Image(0).selfMask();
leftMap.addLayer(blankImg);
rightMap.addLayer(blankImg);
leftMap.add(leftLabel);
rightMap.add(rightLabel);

if(thisData.cloudBand !== '') {
  cloudFracSlider.setDisabled(false);
}
updateLeftSliderDate();
updateRightSliderDate();

// ### CHART DATA ###
var firstChart = true;
function chartTimeSeries() {
  var no2ImgTs = ee.ImageCollection(thisData.colId)
    .filterBounds(aoi)
    .map(function(img){
      return img.set('millis', img.date().millis());
    });
  
  if(thisData.cloudBand !== '') {
    no2ImgTs = no2ImgTs.map(maskClouds);
  }
  no2ImgTs = no2ImgTs.select(thisData.band);
  var dataDateRange = ee.Dictionary(no2ImgTs.reduceColumns(
    {reducer: ee.Reducer.minMax(), selectors: ['system:time_start']}));
  var firstDate = ee.Date(dataDateRange.get('min'));
  var lastDate = ee.Date(dataDateRange.get('max'));
  var nDays = lastDate.difference(firstDate, 'day').add(1);
  var firstMillis = firstDate.millis();
  var nMillis = firstMillis.add(nDays.multiply(8.64e7));
  var stepMillis = 9*8.64e7; 
  var seq = ee.List.sequence(firstMillis, nMillis, stepMillis);
  var targetCol = ee.ImageCollection.fromImages(seq.map(function(i) {
    return ee.Image().set({'millis': i, 'system:time_start': ee.Date(i)});
  }));
  var joinFilter = ee.Filter.maxDifference({
    difference: 8.64e7*4, // 4 days (9-day composite)
    leftField: 'millis',
    rightField: 'millis'});
  targetCol = ee.Join.saveAll('matches').apply(targetCol, no2ImgTs, joinFilter);
  var compCol5 = targetCol.map(function(img) {
    var imgCol = ee.ImageCollection.fromImages(img.get('matches'));
    var imgComp = imgCol.reduce(ee.Reducer.percentile({percentiles: [25, 50, 75], outputNames: ['p25', 'p50', 'p75']}));
      var nBands = imgComp.bandNames().size();
      return imgComp.rename(['p25', 'p50', 'p75']).set({
        'system:time_start': img.get('system:time_start'),
        'nBands': nBands
      });
  }).filter(ee.Filter.gt('nBands', 0));
  
  if(firstChart){
    aoiArea = aoi.area(1000).getInfo();
    firstChart = false;
  }
  var scale = 1000;
  if(aoiArea > 5e11){
    scale = 10000;
  } else if(aoiArea > 1e11) {
    scale = 5000;
  }
  var no2FcTs = ee.FeatureCollection(compCol5.map(function(img) {
    var stat = ee.Image(img)
      .multiply(thisData.scalar)
      .reduceRegion({
        reducer: ee.Reducer.mean(),
        geometry: aoi,
        scale: scale,
        bestEffort: true,
        maxPixels: 1e13
      });
    var imgDate = ee.Date(img.get('system:time_start'));
    return ee.Feature(null, stat).set({
      'system:time_start': imgDate.millis(),
      'doy': imgDate.getRelative('day', 'year'),
      'year': ee.Algorithms.String(imgDate.get('year'))
    });
  }));
  var leftMapDate = ee.Date(ee.List(leftDatePanel.widgets().get(1).getValue()).get(0));
  var rightMapDate = ee.Date(ee.List(rightDatePanel.widgets().get(1).getValue()).get(0));
  var mapPoints = ee.FeatureCollection([
    ee.Feature(null, {
      'system:time_start': leftMapDate.millis(),
      p0: thisData.baseline
    }
    ),
    ee.Feature(null, {
      'system:time_start': rightMapDate.millis(),
      p1: thisData.baseline
    }
    )
  ]);
  no2FcTs = no2FcTs.merge(mapPoints);
  var chart = ui.Chart.feature.groups({
    features: no2FcTs.sort('year'), 
    xProperty: 'doy',
    yProperty: 'p50',
    seriesProperty: 'year'
  })
  .setChartType('LineChart')
  .setOptions({
    height: 245,
    curveType: 'function',
    explorer: {axis: 'vertical'},
    interpolateNulls: true,
    title: 'Yearly',
    vAxis: {
      baseline: thisData.baseline,
      titleTextStyle: {italic: false, fontSize: 14, bold: true},
      title: thisData.unitsLabel,
      gridlines: {count: 0},
    },
    hAxis: {
      titleTextStyle: {italic: false, fontSize: 14, bold: true},
      title: 'Day of the year', 
      gridlines: {count: 4, color: 'FFF'},
      ticks: [0, 100, 200, 300],
    },
    series: {
      0: {
        lineWidth: 0,
        pointSize: 0,
        visibleInLegend: false,
      },
      1: 
      {
        color: '9ebcda',
        lineWidth: 1,
        pointsVisible: false,
      },
      2: 
      {
        color: '8856a7',
        lineWidth: 1,
        pointsVisible: false,
      },
      3: 
      {
        lineWidth: 1,
        color: '000',
        pointsVisible: false,
        
      }
    },
    legend: {position: 'right'},
  });
  var fullTsChart = ui.Chart.feature.byFeature({
    features: no2FcTs.sort('system:time_start'),
    xProperty: 'system:time_start', 
    yProperties: ['p25', 'p50', 'p75', 'p0', 'p1'],
  })
  .setChartType('LineChart')
  .setSeriesNames(['p25', 'Median', 'IQR', 'Left date', 'Right date'])
  .setOptions({
    height: 245,
    curveType: 'function',
    explorer: {axis: 'vertical'},
    interpolateNulls: true,
    title: 'Continuous',
    vAxis: {
      baseline: thisData.baseline,
      titleTextStyle: {italic: false, fontSize: 14, bold: true},
      title: thisData.unitsLabel,
      gridlines: {count: 0},
    },
    hAxis: {
      titleTextStyle: {italic: false, fontSize: 14, bold: true},
      title: 'Date', 
      gridlines: {color: 'FFF'},
    },
    series: {
      0: 
      {
        color: 'B8B8B8',
        lineWidth: 0.7,
        pointsVisible: false,
        pointSize: 0.5,
        dataOpacity: 0.3,
        visibleInLegend: false,
      },
      1: 
      {
        lineWidth: 1.3,
        color: '711F81',
        pointsVisible: false
      },
      2: 
      {
        color: 'B8B8B8',
        lineWidth: 0.7,
        pointsVisible: false,
        pointSize: 0.5,
        dataOpacity: 0.3,
        visibleInLegend: true
      },
      3: 
      {
        color: '60811f',
        lineWidth: 0,
        pointsVisible: true,
        pointSize: 6,
      },
      4: 
      {
        color: '81601f',
        lineWidth: 0,
        pointsVisible: true,
        pointSize: 6,
      },
    },
  });
  tsChart.widgets().set(2, chart);
  tsChart.widgets().set(1, fullTsChart);
  setChart();
}

// ###OUR  EVENT HANDLERS ###
function clearRightGeom() {
  var nLayers = drawingToolsRight.layers().length();
  while (nLayers > 0) {
    var layer = drawingToolsRight.layers().get(0);
    drawingToolsRight.layers().remove(layer);
    nLayers = drawingToolsRight.layers().length();
  }
}

function drawChart() {
  aoi = drawingTools.layers().get(0).getEeObject();
  clearRightGeom();
  drawingToolsRight.addLayer([aoi], null, 'FFF');
  drawingToolsRight.layers().get(0).setLocked(true);
  ui.url.set('aoi', aoi.toGeoJSONString());
  drawingTools.setShape(null);
  aoi.area(1000).evaluate(function(area) {
    aoiArea = area;
    if(area > maxAoiArea){
      print('Drawn geometry is too large.');
      tsChart.widgets().get(0).style().set({shown: true});
      tsChart.widgets().get(1).style().set({shown: false});
      tsChart.widgets().get(2).style().set({shown: false});
      return;
    } else {
      tsChart.widgets().get(0).style().set({shown: false});
      setChart();
      chartTimeSeries();
    }
  });
}

// ### MAP LEGEND SETUP ###
function makeColorBarParams(palette) {
  return {
    bbox: [0, 0, 1, 0.1],
    dimensions: '100x10',
    format: 'png',
    min: 0,
    max: 1,
    palette: palette,
  };
}
function makeLegend() {
  var colorBar = ui.Thumbnail({
    image: ee.Image.pixelLonLat().select(0),
    params: makeColorBarParams(thisData.visParams.palette),
    style: {stretch: 'horizontal', margin: '0px 8px', maxHeight: '20px'},
  });
  var legendLabels = ui.Panel({
    widgets: [
      ui.Label(thisData.visParams.min, {margin: '4px 8px', fontSize: '12px'}), //
      ui.Label(
          (thisData.visParams.max / 2), //
          {margin: '4px 8px', textAlign: 'center', stretch: 'horizontal', fontSize: '12px'}),
      ui.Label(thisData.visParams.max, {margin: '4px 8px', fontSize: '12px'})
    ],
    layout: ui.Panel.Layout.flow('horizontal')
  });
  var legendTitle = ui.Label({
    value: thisData.legendLabel + ' ,9-day mean',
    style: {fontWeight: 'bold', fontSize: '12px'}
  });
  var legendPanel = ui.Panel([legendTitle, colorBar, legendLabels]);
  mapComparison.widgets().set(legendIndex, legendPanel);
}
makeLegend();

// ### DRAWING TOOLS SETUP ###
var chartStatus = ui.url.get('chart', 'cont');
ui.url.set('chart', chartStatus);
var chartButtonLabel = 'Show year to year chart';
if(chartStatus == 'cont') {
  tsChart.widgets().get(1).style().set({shown: true});
  tsChart.widgets().get(2).style().set({shown: false});
} else {
  chartButtonLabel = 'Show continuous chart';
  tsChart.widgets().get(1).style().set({shown: false});
  tsChart.widgets().get(2).style().set({shown: true});  
}
var chartButton = ui.Button(chartButtonLabel, switchChart);
function switchChart() {
  if(chartStatus == 'cont') {
    chartButton.setLabel('Show continuous chart');
    chartStatus = 'yoy';
    ui.url.set('chart', 'yoy');
    tsChart.widgets().get(1).style().set({shown: false});
    tsChart.widgets().get(2).style().set({shown: true});
  } else {
    chartButton.setLabel('Show year to year chart');
    chartStatus = 'cont';
    ui.url.set('chart', 'cont');
    tsChart.widgets().get(1).style().set({shown: true});
    tsChart.widgets().get(2).style().set({shown: false});
  }
}
function setChart() {
  if(chartStatus == 'cont') {
    tsChart.widgets().get(1).style().set({shown: true});
    tsChart.widgets().get(2).style().set({shown: false});
  } else {
    tsChart.widgets().get(1).style().set({shown: false});
    tsChart.widgets().get(2).style().set({shown: true});
  }
}
var symbol = {
  rectangle: '▮',
  polygon: '▲',
  point: '●',
};
var timeSeries = ui.Panel({
  widgets: [
    ui.Label('5. Select your preferred drawing mode:'),
    ui.Panel([
    ui.Button({
      label: symbol.rectangle + ' Rectangle',
      onClick: drawRectangle,
      style: {stretch: 'horizontal', margin:'3px'}}),
    ui.Button({
      label: symbol.polygon + ' Polygon',
      onClick: drawPolygon,
      style: {stretch: 'horizontal', margin:'3px'}}),
    ui.Button({
      label: symbol.point + ' Point',
      onClick: drawPoint,
      style: {stretch: 'horizontal', margin:'3px'}}),
    ], ui.Panel.Layout.flow('horizontal'), {margin: '10px'}),
    // ui.Label('6. Draw a geometry on the Left map.'),
    chartButton
  ],
  style: {position: 'bottom-left'},
  layout: null,
});
var panelBreak50 = ui.Panel(null, null, {stretch: 'horizontal', height: '1px', margin: '8px 0px 8px 0px'});
infoPanel.add(panelBreak50);
infoPanel.add(timeSeries);

function clearGeometry(){
  var layers = drawingTools.layers();
  layers.get(0).geometries().remove(layers.get(0).geometries().get(0));
}
function clearGeometryRight(){
  var layers = drawingToolsRight.layers();
  layers.get(0).geometries().remove(layers.get(0).geometries().get(0));
}
var drawType = '';
function drawRectangle(){
  drawType = 'rectangle';
  clearGeometry();
  clearRightGeom();
  drawingTools.setShape('rectangle');
  drawingTools.draw();
}
function drawPolygon(){
  drawType = 'polygon';
  clearGeometry();
  clearRightGeom();
  drawingTools.setShape('polygon');
  drawingTools.draw();
}
function drawPoint(){
  drawType = 'point';
  clearGeometry();
  clearRightGeom();
  drawingTools.setShape('point');
  drawingTools.draw();
}

drawingTools.onEdit(ui.util.debounce(drawChart, 500));
drawingTools.onDraw(ui.util.debounce(drawChart, 500));
var panelBreak100 = ui.Panel(null, null, {stretch: 'horizontal', height: '1px', backgroundColor: '000', margin: '8px 0px 8px 0px'});
infoPanel.add(panelBreak100);



