package trilateralXtra.kDrawing.svg;
import trilateral.nodule.Nodule;
typedef ViewBox_ = { x: Int, y: Int, width: Int, height: Int }
abstract ViewBox( ViewBox_) from ViewBox_ to ViewBox_ {
    public inline function new( val: ViewBox ){
        this = val;
    }
    @:from
    static public function fromString( s: String ): ViewBox {
        var arr = s.split(' ');
        return new ViewBox( 
            { x:        Std.parseInt( arr[ 0 ] )
            , y:        Std.parseInt( arr[ 1 ] )
            , width:    Std.parseInt( arr[ 2 ] )
            , height:   Std.parseInt( arr[ 3 ] ) 
            }
        );
    }
}
abstract SharpColor( Int ) from Int to Int {
    public inline function new( val: Int ){
        this = val;
    }
    @:from
    static public function fromString( s: String ): SharpColor {
        var temp: String;
        var out: Int = 0;
        if( s.length == 4 ){
            var r = s.substr( 1, 1 );
            var g = s.substr( 2, 1 );
            var b = s.substr( 3, 1 );
            temp = '0xFF'+r+r+g+g+b+b;
            out = Std.parseInt( temp );
        } else if( s.length == 7 ){
            temp = '0xFF' + s.substr( 1, 6 );
            out = Std.parseInt( temp );
        }
        return new SharpColor( out );
    }
}
abstract FloatString( Float ) from Float to Float {
    public inline function new( val: Float ){
        this = val;
    }
    @:from
    static public function fromString( s: String ): FloatString {
        return new FloatString( Std.parseFloat( s ) );
    }
}
abstract Version( Float ) from Float to Float {
    public inline function new( val: Float ){
        this = val;
    }
    @:from
    static public function fromString( s: String ): Version {
        return new Version( Std.parseFloat( s ) );
    }
    public function major(): Int {
        return Math.floor( this );
    }
    public function minor(): Int {
        return Std.parseInt( Std.string( this-major() ).split('.')[1] );
    }
}
abstract Stroke_Width( Float ) from Float to Float {
    public inline function new( val: Float ){
        this = val;
    }
    @:from
    static public function fromString( s: String ): Stroke_Width {
        return new Stroke_Width( Std.parseFloat( s ) );
    }
}
abstract Matrix( Matrix_ ) from Matrix_ to Matrix_ {
    public inline function new( val: Matrix_ ){
        this = val;
    }
    @:from
    static public function fromString( s: String ): Matrix {
        var start = s.indexOf('(') +1;
        var end = s.indexOf(')') -1; 
        s = s.substr( start, end-start );
        var arr = s.split(',');
        trace( 'arr ' + s );
        return new Matrix( {    a: arr[ 0 ]
                            ,   b: arr[ 1 ]
                            ,   c: arr[ 2 ]
                            ,   d: arr[ 3 ]
                            ,   e: arr[ 4 ]
                            ,   f: arr[ 5 ]
                            } );
    }
}
@:forward
abstract Group( Group_ ) from Group_ to Group_ {
    public inline function new( val: Group_ ){
        this = val;
    }
    public inline function attributeAdd( at: { name: String,value: String } ){
        switch( at.name ){
            case 'id':
                this.id            = at.value;
            case 'xmlns':
                this.xmlns         = at.value;
            case 'viewBox':
                this.viewBox       = at.value;
            case 'version':
                this.version       = at.value;
            case 'fill':
                this.fill          = at.value;
            case 'transform':
                this.transform     = at.value;
            case 'stroke-width':
                this.stroke_width  = at.value;
            case 'stroke':
                this.stroke        = at.value;
            case _:
                trace( 'group attribute ' + at.name + ' not found ' );
        }
    }
}
typedef Group_ = {
        ?id:           String
    ,   ?xmlns:        String
    ,   ?viewBox:      ViewBox
    ,   ?version:      Version
    ,   ?fill:         SharpColor
    ,   ?transform:    Matrix
    ,   ?stroke_width: Stroke_Width
    ,   ?stroke:       SharpColor
    ,   ?firstChild:   Nodule
}
typedef Matrix_ = {
        a: FloatString
    ,   b: FloatString
    ,   c: FloatString
    ,   d: FloatString
    ,   e: FloatString
    ,   f: FloatString
}