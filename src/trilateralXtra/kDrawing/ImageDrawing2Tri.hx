package trilateralXtra.kDrawing;
import trilateral.tri.TriangleArray;
import trilateral.tri.Triangle;
import trilateral.path.Base;
import trilateral.path.Fine;
import trilateralXtra.kDrawing.PolyPainter;
import hxPolyK.PolyK;
import org.poly2tri.VisiblePolygon;
import trilateralXtra.kDrawing.ImageDrawing;
class ImageDrawing2Tri extends ImageDrawing {
    public
    function new( ?w: Int, ?h: Int ){
        super( w, h );
    }
    // utilize base.pointsNoEndOverlap() to get clean points!
    override public
    function fill( points: Array<Array<Float>>, colorID: Int ){
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
        var triples = new ArrayTriple( tri );
        var i: Int;
        for( tri in triples ){
            var a: Int = Std.int( tri.a*3 );
            var b: Int = Std.int( tri.b*3 );
            var c: Int = Std.int( tri.c*3 );
            triangles.drawTriangle(  count, { x: vert[ a ], y: vert[ a + 1 ] }
                                       , { x: vert[ b ], y: vert[ b + 1 ] }
                                       , { x: vert[ c ], y: vert[ c + 1 ] }, colorID );
        }
    }
    override public
    function fillRnd( points: Array<Array<Float>>, rnd: Int ){
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
        var triples = new ArrayTriple( tri );
        var i: Int;
        for( tri in triples ){
            var a: Int = Std.int( tri.a*3 );
            var b: Int = Std.int( tri.b*3 );
            var c: Int = Std.int( tri.c*3 );
            triangles.drawTriangle(  count, { x: vert[ a ], y: vert[ a + 1 ] }
                                       , { x: vert[ b ], y: vert[ b + 1 ] }
                                       , { x: vert[ c ], y: vert[ c + 1 ] }, Std.int( Math.round( Math.random()*rnd ) ) );//colorID );
        }
    }
    override public
    function pathFactory(): Base {
        var pen = new Fine( null, null, null );// both );
        return cast pen;
    }
}