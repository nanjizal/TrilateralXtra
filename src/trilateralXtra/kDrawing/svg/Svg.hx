package trilateralXtra.kDrawing.svg;
import trilateralXtra.kDrawing.svg.Path;
import trilateralXtra.kDrawing.svg.Group;
import trilateral.nodule.AttributePairs;
import trilateral.nodule.Nodule;
import trilateral.justPath.SvgPath;
import trilateral.path.FillOnly;
import trilateral.path.Crude;
import trilateral.path.Fine;
import trilateral.path.Base;
import trilateralXtra.kDrawing.ImageDrawing;
typedef HasAttribute = {
    public function attributeAdd( at: { name: String,value: String } ): Void;
}
class Svg{
    public var imageDrawing: ImageDrawing;
    public var groups: Array<Group>;//
    public var group: Group;
    public var nodule: Nodule;
    public function new( nodule_: Nodule ){
        nodule = nodule_;
        
    }
    public function render( imageDrawing_: ImageDrawing ){
        imageDrawing = imageDrawing_;
        parseChild( nodule );
    }
    public inline
    function parseChild( nodule: Nodule ){
        var childs: Array<Nodule> = nodule.childNodules( new Array() );
        for( kid in childs ){
            switch( kid.name ){
                case 'g':
                    var g = parseGroup( kid );
                case 'path':
                    var p = parsePath( kid );
            }
        }
    }
    public inline
    function parseGroup( kid: Nodule ): Group {
        var g: Group = {};
        //addAttributes( cast g, kid );
        for( at in kid.attributes( [] ) ) g.attributeAdd( at );
        // trace( 'g ' + g );
        group = g;
        if( kid.firstChild != null ) {
            parseChild( kid );
        }
        return g;
    }
    public inline
    function parsePath( kid: Nodule ): Path {
        var p: Path = {};
        //addAttributes( cast p, kid );
        for( at in kid.attributes( [] ) ) p.attributeAdd( at );
        // trace( 'path ' + p );
        // composite group with group properties above like matrix in realistic render, pushing poping on group
        // arigate group values?
        renderPath( group, p ); 
        return p;
    }
    public inline static 
    function addAttributes( hasAtt: HasAttribute, kid: Nodule ){
        for( at in kid.attributes( [] ) ) hasAtt.attributeAdd( at );
    }
    public function renderPath( group: Group, path: Path ){
        var black            = imageDrawing.colorId( 0xFF000000 );
        var hasFill          = ( group.fill != null )? true: false; 
        var solidColor: Int  = ( hasFill )? imageDrawing.colorId( group.fill ): black;
        var hasStroke        = ( group.stroke != null )? true: false;
        var lineColor: Int   = ( hasStroke )? imageDrawing.colorId( group.stroke ): black;
        var stroke_width: Float = group.stroke_width;
        var lineWidth: Float = ( stroke_width != null )? stroke_width/2: 0.;
        if( hasStroke ){
            var pen = imageDrawing.pathFactory();
            pen.width = lineWidth;
            ( new SvgPath( pen ) ).parse( path.d );
            if( hasFill ) imageDrawing.fill( pen.points, solidColor );
            imageDrawing.triangles.addArray( imageDrawing.count, pen.trilateralArray, lineColor );
        } else if( hasFill ){
            var fillOnly = new FillOnly();
            fillOnly.width = 1.;
            ( new SvgPath( fillOnly ) ).parse( path.d );
            imageDrawing.fill( fillOnly.points, solidColor );
        }
    }
}