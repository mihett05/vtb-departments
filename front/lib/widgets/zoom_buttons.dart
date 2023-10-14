import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class ZoomButtons extends StatelessWidget {
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;
  final Future<void> Function()? onCenter;

  static const _fitBoundsPadding = EdgeInsets.all(12);

  const ZoomButtons({
    super.key,
    this.minZoom = 1,
    this.maxZoom = 18,
    this.mini = true,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
    this.onCenter,
  });

  @override
  Widget build(BuildContext context) {
    final camera = MapCamera.of(context);

    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: mini,
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                final paddedMapCamera = CameraFit.bounds(
                  bounds: camera.visibleBounds,
                  padding: _fitBoundsPadding,
                ).fit(camera);
                var zoom = paddedMapCamera.zoom.ceilToDouble() + 1;
                if (zoom > maxZoom) {
                  zoom = maxZoom;
                }
                MapController.of(context).move(paddedMapCamera.center, zoom);
              },
              child:
                  Icon(Icons.add_rounded, color: IconTheme.of(context).color),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: mini,
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                final paddedMapCamera = CameraFit.bounds(
                  bounds: camera.visibleBounds,
                  padding: _fitBoundsPadding,
                ).fit(camera);
                var zoom = paddedMapCamera.zoom.ceilToDouble() - 1;
                if (zoom < minZoom) {
                  zoom = minZoom;
                }
                MapController.of(context).move(paddedMapCamera.center, zoom);
              },
              child: Icon(Icons.remove_rounded,
                  color: IconTheme.of(context).color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: FloatingActionButton(
              heroTag: 'centerButton',
              mini: mini,
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                if (onCenter != null) {
                  onCenter!();
                }
              },
              child: ImageIcon(AssetImage("assets/icons/gpsSolid.png")),
              // Icon(
              //   Icons.my_location,
              //   color: IconTheme.of(context).color,
              // ),
            ),
          )
        ],
      ),
    );
  }
}
