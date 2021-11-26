package com.example.app;

import java.util.List;
import java.util.concurrent.ExecutionException;

import com.esri.arcgisruntime.mapping.Viewpoint;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;

import com.esri.arcgisruntime.concurrent.ListenableFuture;
import com.esri.arcgisruntime.mapping.view.Graphic;
import com.esri.arcgisruntime.mapping.view.GraphicsOverlay;
import com.esri.arcgisruntime.symbology.SimpleMarkerSymbol;
import com.esri.arcgisruntime.symbology.TextSymbol;
import com.esri.arcgisruntime.tasks.geocode.GeocodeParameters;
import com.esri.arcgisruntime.tasks.geocode.GeocodeResult;
import com.esri.arcgisruntime.tasks.geocode.LocatorTask;

import com.esri.arcgisruntime.ArcGISRuntimeEnvironment;
import com.esri.arcgisruntime.geometry.Point;
import com.esri.arcgisruntime.geometry.SpatialReferences;
import com.esri.arcgisruntime.mapping.ArcGISScene;
import com.esri.arcgisruntime.mapping.ArcGISTiledElevationSource;
import com.esri.arcgisruntime.mapping.Basemap;
import com.esri.arcgisruntime.mapping.Surface;
import com.esri.arcgisruntime.mapping.view.Camera;
import com.esri.arcgisruntime.mapping.view.SceneView;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;



public class App extends Application {

    private SceneView sceneView;


    public static void main(String[] args) {
        Application.launch(args);
    }





    @Override
    public void start(Stage stage) {

        // set the title and size of the stage and show it
        stage.setTitle("Display a scene tutorial");
        stage.setWidth(800);
        stage.setHeight(700);
        stage.show();

        // create a JavaFX scene with a stack pane as the root node, and add it to the scene
        StackPane stackPane = new StackPane();
        Scene fxScene = new Scene(stackPane);

        stage.setScene(fxScene);

        // Note: it is not best practice to store API keys in source code.
        // The API key is referenced here for the convenience of this tutorial.
        String yourApiKey = "AAPK0a48607720df4f1abcf8a2b4d5d53418ErSVO4mqT6JY-1WkiLJ2r89iRvksCj6iUEDglICQk02fhz9i0uegGB0m9l_kJGUG";
        ArcGISRuntimeEnvironment.setApiKey(yourApiKey);

        // create a scene view to display the scene and add it to the stack pane
        sceneView = new SceneView();
        stackPane.getChildren().add(sceneView);

        ArcGISScene scene = new ArcGISScene(Basemap.createImagery());

        // set the scene on the scene view
        sceneView.setArcGISScene(scene);

        // add base surface for elevation data
        Surface surface = new Surface();
        String elevationServiceUrl = "https://elevation3d.arcgis.com/arcgis/rest/services/WorldElevation3D/Terrain3D/ImageServer";
        surface.getElevationSources().add(new ArcGISTiledElevationSource(elevationServiceUrl));
        // add an exaggeration factor to increase the 3D effect of the elevation.
        surface.setElevationExaggeration(2.5f);

        scene.setBaseSurface(surface);

        // add a camera and initial camera position (Snowdonia National Park)

        Point cameraLocation = new Point(-118.794, 33.909, 5330.0, SpatialReferences.getWgs84());
        Camera camera = new Camera(cameraLocation, 355.0, 72.0, 0.0);
//        Camera camera = new Camera(53.06, -4.04, 1289.0, 295.0, 71.0, 0.0);
        sceneView.setViewpointCamera(camera);

    }

    @Override
    public void stop() {
        if (sceneView != null) {
            sceneView.dispose();
        }
    }

}


//import com.esri.arcgisruntime.portal.Portal;
//import com.esri.arcgisruntime.portal.PortalItem;
//
//import com.esri.arcgisruntime.geometry.Point;
//import com.esri.arcgisruntime.geometry.PointCollection;
//import com.esri.arcgisruntime.geometry.Polygon;
//import com.esri.arcgisruntime.geometry.Polyline;
//import com.esri.arcgisruntime.geometry.SpatialReferences;
//import com.esri.arcgisruntime.mapping.view.Graphic;
//import com.esri.arcgisruntime.mapping.view.GraphicsOverlay;
//import com.esri.arcgisruntime.symbology.SimpleFillSymbol;
//import com.esri.arcgisruntime.symbology.SimpleLineSymbol;
//import com.esri.arcgisruntime.symbology.SimpleMarkerSymbol;
//
//import com.esri.arcgisruntime.ArcGISRuntimeEnvironment;
//import com.esri.arcgisruntime.mapping.ArcGISMap;
//import com.esri.arcgisruntime.mapping.BasemapStyle;
//import com.esri.arcgisruntime.mapping.Viewpoint;
//import com.esri.arcgisruntime.mapping.view.MapView;
//
//import javafx.application.Application;
//import javafx.scene.Scene;
//import javafx.scene.layout.StackPane;
//import javafx.stage.Stage;
//
//public class App extends Application {
//
//    private MapView mapView;
//
//    public static void main(String[] args) {
//        Application.launch(args);
//
//    }
//
//    @Override
//    public void start(Stage stage) {
//
//        // set the title and size of the stage and show it
//        stage.setTitle("Display a map tutorial");
//        stage.setWidth(800);
//        stage.setHeight(700);
//        stage.show();
//
//        // create a JavaFX scene with a stack pane as the root node, and add it to the scene
//        StackPane stackPane = new StackPane();
//        Scene scene = new Scene(stackPane);
//
//        stage.setScene(scene);
//
//        // Note: it is not best practice to store API keys in source code.
//        // The API key is referenced here for the convenience of this tutorial.
//        String yourApiKey = "AAPK0a48607720df4f1abcf8a2b4d5d53418ErSVO4mqT6JY-1WkiLJ2r89iRvksCj6iUEDglICQk02fhz9i0uegGB0m9l_kJGUG";
//        ArcGISRuntimeEnvironment.setApiKey(yourApiKey);
//
//        // create a map view to display the map and add it to the stack pane
//        mapView = new MapView();
//        stackPane.getChildren().add(mapView);
//
//        Portal portal = new Portal("https://www.arcgis.com", false);
//        String itemId = "41281c51f9de45edaf1c8ed44bb10e30";
//        PortalItem portalItem = new PortalItem(portal, itemId);
//        ArcGISMap map = new ArcGISMap(portalItem);
//
////        mapView.setMap(map);
//
////        ArcGISMap map = new ArcGISMap(BasemapStyle.ARCGIS_TOPOGRAPHIC);
//
//        // set the map on the map view
//        mapView.setMap(map);
//
//        mapView.setViewpoint(new Viewpoint(34.02700, -118.80543, 144447.638572));
//
//        // create a graphics overlay and add it to the map view
//        GraphicsOverlay graphicsOverlay = new GraphicsOverlay();
//        mapView.getGraphicsOverlays().add(graphicsOverlay);
//
//        // create a point geometry with a location and spatial reference
//        Point point = new Point(-118.80657463861, 34.0005930608889, SpatialReferences.getWgs84());
//        // create an opaque orange (0xFFFF5733) point symbol with a blue (0xFF0063FF) outline symbol
//        SimpleMarkerSymbol simpleMarkerSymbol =
//                new SimpleMarkerSymbol(SimpleMarkerSymbol.Style.CIRCLE, 0xFFFF5733, 10);
//        SimpleLineSymbol blueOutlineSymbol =
//                new SimpleLineSymbol(SimpleLineSymbol.Style.SOLID, 0xFF0063FF, 2);
//
//        simpleMarkerSymbol.setOutline(blueOutlineSymbol);
//
//        // create a graphic with the point geometry and symbol
//        Graphic pointGraphic = new Graphic(point, simpleMarkerSymbol);
//
//        // add the point graphic to the graphics overlay
//        graphicsOverlay.getGraphics().add(pointGraphic);
//
//        // create a point collection with a spatial reference, and add three points to it
//        PointCollection polylinePoints = new PointCollection(SpatialReferences.getWgs84());
//        polylinePoints.add(new Point(-118.821527826096, 34.0139576938577));
//        polylinePoints.add(new Point(-118.814893761649, 34.0080602407843));
//        polylinePoints.add(new Point(-118.808878330345, 34.0016642996246));
//        // create a polyline geometry from the point collection
//        Polyline polyline = new Polyline(polylinePoints);
//
//        // create a blue line symbol for the polyline
//        SimpleLineSymbol polylineSymbol =
//                new SimpleLineSymbol(SimpleLineSymbol.Style.SOLID, 0xFF0063FF, 3);
//
//        // create a polyline graphic with the polyline geometry and symbol
//        Graphic polylineGraphic = new Graphic(polyline, polylineSymbol);
//
//        // add the polyline graphic to the graphics overlay
//        graphicsOverlay.getGraphics().add(polylineGraphic);
//
//        // create a point collection with a spatial reference, and add five points to it
//        PointCollection polygonPoints = new PointCollection(SpatialReferences.getWgs84());
//        polygonPoints.add(new Point(-118.818984489994, 34.0137559967283));
//        polygonPoints.add(new Point(-118.806796597377, 34.0215816298725));
//        polygonPoints.add(new Point(-118.791432890735, 34.0163883241613));
//        polygonPoints.add(new Point(-118.795966865355, 34.0085648646355));
//        polygonPoints.add(new Point(-118.808558110679, 34.0035027131376));
//        // create a polygon geometry from the point collection
//        Polygon polygon = new Polygon(polygonPoints);
//
//        // create an orange fill symbol with 20% transparency and the blue simple line symbol
//        SimpleFillSymbol polygonFillSymbol =
//                new SimpleFillSymbol(SimpleFillSymbol.Style.SOLID, 0x80FF5733, blueOutlineSymbol);
//
//        // create a polygon graphic from the polygon geometry and symbol
//        Graphic polygonGraphic = new Graphic(polygon, polygonFillSymbol);
//        // add the polygon graphic to the graphics overlay
//        graphicsOverlay.getGraphics().add(polygonGraphic);
//    }
//
//    /**
//     * Stops and releases all resources used in application.
//     */
//    @Override
//    public void stop() {
//        if (mapView != null) {
//            mapView.dispose();
//        }
//    }
//}