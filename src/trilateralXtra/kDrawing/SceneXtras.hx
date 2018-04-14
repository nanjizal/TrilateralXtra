package trilateralXtra.kDrawing;
import trilateralXtra.kDrawing.PolyPainter;
import kha.Image;
class SceneXtras {
    public static inline
    function sky( poly: PolyPainter ){
        var blueRed = 0xFF6F73F3;//blueWithBitOfRed
        var blueGreen = 0xFFB0EaF5;//blueWithBitOfGreen
        var topUp = -200;// cheat moved top up to soften the darkest blue, rather than tweaking all colors.
        poly.drawGradientTriangle( 0, topUp, 400, topUp, 0, 400, blueRed, 0xFF4F78EE, 0xFFAECFF5 );
        poly.drawGradientTriangle( 0, 400, 400, topUp, 400, 400, 0xFFAECFF5, 0xFF4F78EE, 0xFF8CA9EE );
        poly.drawGradientTriangle( 400, topUp, 800, topUp, 400, 400, 0xFF4F78EE, 0xFF1D5FEC, 0xFF8CA9EE );
        poly.drawGradientTriangle( 400, 400, 800, topUp, 800, 400, 0xFF8CA9EE, 0xFF1D5FEC, blueGreen );
    }
    public static inline
    function grass( poly: PolyPainter, grassImage: Image ){
        // use the gradient version to tint image to give a bit more life to the tiling.
        poly.drawImageTriangleGradient( 0, 400, 800, 400, 800, 600, 0, 0, 8, 0, 8, 2, grassImage, 0xa000ff00, 0xe0f0ffff, 0xe0f0ffff );
        poly.drawImageTriangleGradient( 0, 400, 800, 600, 0, 600, 0, 0, 8, 2, 0, 2, grassImage , 0xa000ff00, 0xe0f0ffff, 0xe0f0ffff );
    }
}