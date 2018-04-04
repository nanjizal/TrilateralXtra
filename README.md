# TrilateralXtra
TrilateralXtra provides non core and partially developed features for Trilateral a triangle contour engine for Haxe cross target development.
To use this you will require Trilateral.  Examples of use can be found in TrilateralBazzar.

## trilateralXtra.segments

The **trilateralXtra.segments** package provides 7 and 16 segments style displays and a 5x7 dot matrix display emulation with scrolling.

### SevenSeg

This is an old school seven segment display, out of the box it supports hex digits:

```haxe
// setup width and height
var width = 20.;
var height = 30.;
var seven = new SevenSeg( width, height );

// set characters and position, see also addNumber
var x = 100.;
var y = 100.;
seven.addChar( '0123456789abcdef', 20, 30 );

// get the triangles created
var tri: Array<Trilateral> = seven.triArr;
    
// use trilateral to color triangles and render them to screen see examples on TrilateralBazzar.
```
### SixteenSeg
This is fairly similar to the seven segment but with more segments is more expressive.


### Character5x7
Along with DotMatrix this provides simple 7x5 dot matrix characters, scrolling can be added.




## trilateralXtra.fxg

This provides some parsing of Adobe FXG format currently only very basic implementions of Group and Path have been implemented.  
FXG can be obtained from a swf via third party tool.
Stroke and solid color parsed within the file. Group uses **Nodules**, a recursive generic structure that allows very fast access.

#### currently supported

    - Group
    - Path
    
In future the implementation maybe extended to support more features, contributions welcome:

#### Not currently supported

    - BitmapFill
    - BitmapImage.hx
    - ColorTransform.hx
    - Definition.hx
    - Ellipse.hx
    
    - GradientEntry.hx
    - Graphic.hx
    - Line.hx
    - LinearGradient.hx
    - LinearGradientStroke.hx
    - Matrix.hx
    - RadialGradient.hx
    - RadialGradientStroke.hx
    - Rect.hx
    - Transform.hx

#### parsed directly within trilateralXtra.fxg.Path
    - SolidColorStroke.hx
    - SolidColor.hx
    - Fill.hx
    - Stroke.hx
    
    
    
## color.PalletNine

This is a selection of colors in sets of 9.
    - The first 9 are "Real Rainbow colors" black,red -> violet, white
    - The next 27 are a wider range of rainbow colors that work well, with the last 3 being Light Grey, Mid Grey and Dark Grey
    - The rest are ranges of 9 colors suitable for aspects like map data based loosely on colorbrewer2, saves you selecting a reasonable pallet.
    
### color.AppColors

These may well be depreciated they are abstract enum definitions of some Rainbow colors, but a lot less than PalletNine.

 
 
 
 
