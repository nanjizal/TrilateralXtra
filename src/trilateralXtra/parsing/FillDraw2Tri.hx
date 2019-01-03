package trilateralXtra.parsing;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Base;
import trilateral.path.Fine;
import hxPolyK.PolyK;
import org.poly2tri.VisiblePolygon;
import trilateral.parsing.FillDraw;
class FillDraw2Tri extends FillDraw {
    public
    function new( ?w: Int, ?h: Int ){
        super( w, h );
    }
    override
    function fillFunc( p: Array<Array<Float>> ):TfillDatas {
        var vp = new VisiblePolygon();
        var l = points.length;
        var p: Array<Float>;
        for( i in 0...l ){
            p = points[ i ];
            if( p.length != 0 ) {
                var p2t: Array<org.poly2tri.Point> = [];
                var pairs = new ArrayPairs<Float>( p );
                var p0 = pairs[0].x;
                var p1 = pairs[0].y;
                for( pair in pairs ) p2t.push( new org.poly2tri.Point( pair.x, pair.y ) );
                var l2 = p2t.length;
                if( p0 == p2t[ l2 - 1 ].x && p1 == p2t[ l2 - 1 ].y ){
                    p2t.pop();
                }
                vp.addPolyline( p2t );
            }
        }
        vp.performTriangulationOnce();
        var pt = vp.getVerticesAndTriangles();
        var tri = pt.triangles;
        var vert = pt.vertices;
        return { vert: vert, tri: tri }
    }
    override public
    function pathFactory(): Base {
        var pen = new Fine( null, null, null );// both );
        return cast pen;
    }
}