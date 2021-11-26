//   Copyright 2020 Esri
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.

package com.example.app;

import com.esri.arcgisruntime.concurrent.ListenableFuture;
import com.esri.arcgisruntime.geometry.Geometry;
import com.esri.arcgisruntime.mapping.BasemapStyle;
import com.esri.arcgisruntime.mapping.Viewpoint;
import com.esri.arcgisruntime.mapping.view.Graphic;
import com.esri.arcgisruntime.mapping.view.GraphicsOverlay;
import com.esri.arcgisruntime.symbology.SimpleLineSymbol;
import com.esri.arcgisruntime.symbology.SimpleMarkerSymbol;
import com.esri.arcgisruntime.tasks.networkanalysis.Route;
import com.esri.arcgisruntime.tasks.networkanalysis.RouteParameters;
import com.esri.arcgisruntime.tasks.networkanalysis.RouteResult;
import com.esri.arcgisruntime.tasks.networkanalysis.RouteTask;
import com.esri.arcgisruntime.tasks.networkanalysis.Stop;

import javafx.collections.FXCollections;
import javafx.collections.ListChangeListener;
import javafx.collections.ObservableList;
import javafx.geometry.Point2D;
import javafx.geometry.Pos;
import javafx.scene.control.Alert;
import javafx.scene.control.ListView;
import javafx.scene.input.MouseButton;
import java.util.List;

import com.esri.arcgisruntime.ArcGISRuntimeEnvironment;
import com.esri.arcgisruntime.mapping.ArcGISMap;
import com.esri.arcgisruntime.mapping.view.MapView;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

public class App3 extends Application {

    private MapView mapView;

    private Graphic routeGraphic;
    private RouteTask routeTask;
    private RouteParameters routeParameters;
    private final ObservableList<Stop> routeStops = FXCollections.observableArrayList();
    private final ListView<String> directionsList = new ListView<>();

    public static void main(String[] args) {
        Application.launch(args);
    }

    @Override
    public void start(Stage stage) {

        // set the title and size of the stage and show it
        stage.setTitle("Find a route and directions tutorial");
        stage.setWidth(800);
        stage.setHeight(700);
        stage.show();

        // create a JavaFX scene with a stack pane as the root node
        // and add it to the scene
        StackPane stackPane = new StackPane();
        Scene scene = new Scene(stackPane);

        stage.setScene(scene);

        // Note: it is not best practice to store API keys in source code.
        // The API key is referenced here for the convenience of this tutorial.
        String yourApiKey = "AAPK0a48607720df4f1abcf8a2b4d5d53418ErSVO4mqT6JY-1WkiLJ2r89iRvksCj6iUEDglICQk02fhz9i0uegGB0m9l_kJGUG";
        ArcGISRuntimeEnvironment.setApiKey(yourApiKey);

        // create a MapView to display the map and add it to the stack pane
        mapView = new MapView();
        stackPane.getChildren().add(mapView);

        ArcGISMap map = new ArcGISMap(BasemapStyle.ARCGIS_STREETS);

        // set the map on the map view
        mapView.setMap(map);

        mapView.setViewpoint(new Viewpoint(34.05398, -118.24532, 144447.638572));

        directionsList.setMaxSize(400, 250);
        stackPane.getChildren().add(directionsList);
        StackPane.setAlignment(directionsList, Pos.TOP_LEFT);

        GraphicsOverlay graphicsOverlay = new GraphicsOverlay();
        mapView.getGraphicsOverlays().add(graphicsOverlay);

        routeTask = new RouteTask("https://route-api.arcgis.com/arcgis/rest/services/World/Route/NAServer/Route_World");

        ListenableFuture<RouteParameters> routeParametersFuture = routeTask.createDefaultParametersAsync();
        routeParametersFuture.addDoneListener(() -> {
            try {
                routeParameters = routeParametersFuture.get();
                routeParameters.setReturnDirections(true);
                directionsList.getItems().add("Click to add two points to the map to find a route.");

            } catch (Exception e) {
                Alert alert = new Alert(Alert.AlertType.ERROR, e.toString());
                alert.show();
                e.printStackTrace();
            }
        });

        addStopsOnMouseClicked();

        routeStops.addListener((ListChangeListener<Stop>) e -> {
            // track the number of stops added to the map, and use it create graphic geometry and symbol text
            int routeStopsSize = routeStops.size();
            // handle user interaction
            if (routeStopsSize == 0) {
                return;
            } else if (routeStopsSize == 1) {
                graphicsOverlay.getGraphics().clear();
                if (!directionsList.getItems().isEmpty())
                    directionsList.getItems().clear();
                directionsList.getItems().add("Click to add two points to the map to find a route.");
            }
            // create a blue circle symbol for the stop
            SimpleMarkerSymbol stopMarker = new SimpleMarkerSymbol(SimpleMarkerSymbol.Style.CIRCLE, 0xff0000ff, 20);
            // get the stop's geometry
            Geometry routeStopGeometry = routeStops.get(routeStopsSize - 1).getGeometry();

            graphicsOverlay.getGraphics().add(new Graphic(routeStopGeometry, stopMarker));

            if (routeStopsSize == 2) {
                // remove the mouse clicked event if two stops have been added
                mapView.setOnMouseClicked(null);
                routeParameters.setStops(routeStops);

                // get the route and display it
                ListenableFuture<RouteResult> routeResultFuture = routeTask.solveRouteAsync(routeParameters);
                routeResultFuture.addDoneListener(() -> {
                    try {
                        RouteResult result = routeResultFuture.get();
                        List<Route> routes = result.getRoutes();

                        if (!routes.isEmpty()) {
                            Route route = routes.get(0);
                            Geometry shape = route.getRouteGeometry();
                            routeGraphic = new Graphic(shape, new SimpleLineSymbol(SimpleLineSymbol.Style.SOLID, 0xff0000ff, 2));
                            graphicsOverlay.getGraphics().add(routeGraphic);

                            // get the direction text for each maneuver and display it as a list in the UI
                            route.getDirectionManeuvers().forEach(step -> directionsList.getItems().add(step.getDirectionText()));
                            // reset stops and re-enable mapview interactions once the route task has completed
                            routeStops.clear();
                            addStopsOnMouseClicked();
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    }
                });
            }
        });

    }

    private void addStopsOnMouseClicked() {
        mapView.setOnMouseClicked(event -> {
            if (event.isStillSincePress() && event.getButton() == MouseButton.PRIMARY) {
                Point2D mapPoint = new Point2D(event.getX(), event.getY());
                routeStops.add(new Stop(mapView.screenToLocation(mapPoint)));
            }
        });
    }

    /**
     * Stops and releases all resources used in application.
     */
    @Override
    public void stop() {
        if (mapView != null) {
            mapView.dispose();
        }
    }

}