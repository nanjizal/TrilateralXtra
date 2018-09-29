package trilateralXtra.color;
// These colors are in sets of 9 from light to dark so you can display just 9 at at time, subset of some colors seen on colorbrewer2.
// useful for experimentation.
class PalletNine {
    public inline function ARGB(){
                // real rainbow colors + black and white
        return [  0xFF000000 // black
                , 0xFFFF0000 // red
                , 0xFFFF7F00 // orange
                , 0xFFFFFF00 // yellow
                , 0xFF00ff00 // green
                , 0xFF0000FF // blue
                , 0xFF4b0082 // indigo
                , 0xFF9400D3 // violet
                , 0xFFFFFFFF // white
                // My hand created Rainbow Colors
                , 0xFFD2D0C1  
                , 0xFFCD8028
                , 0xFFD29D11
                , 0xFFE37128
                , 0xFFF06771
                , 0xFFD23931
                , 0xFFAF2C31
                , 0xFF90333E
                , 0xFF863D50
                
                , 0xFF584A5D
                , 0xFF549EC3
                , 0xFF2C709D
                , 0xFF457AAE
                , 0xFF364D6D
                , 0xFF378C6D
                , 0xFF6EA748
                , 0xFF365DA4
                , 0xFF456E42
                
                , 0xFFC1882E
                , 0xFF813424
                , 0xFF402E24
                , 0xFF292420
                , 0xFF525751
                , 0xFF1B1B19
        
                , 0xFF444444 // LightGrey
                , 0xFF333333 // MidGrey
                , 0xFF0c0c0c // DarkGrey  
                // sequential multi
                , 0xFFf7fcfd
                , 0xFFe5f5f9
                , 0xFFccece6
                , 0xFF99d8c9
                , 0xFF66c2a4
                , 0xFF41ae76
                , 0xFF238b45
                , 0xFF006d2c
                , 0xFF00441b
                , 0xFFf7fcfd
                , 0xFFe0ecf4
                , 0xFFbfd3e6
                , 0xFF9ebcda
                , 0xFF8c96c6
                , 0xFF8c6bb1
                , 0xFF88419d
                , 0xFF810f7c
                , 0xFF4d004b
                , 0xFFf7fcf0
                , 0xFFe0f3db
                , 0xFFccebc5
                , 0xFFa8ddb5
                , 0xFF7bccc4
                , 0xFF4eb3d3
                , 0xFF2b8cbe
                , 0xFF0868ac
                , 0xFF084081
                , 0xFFfff7ec
                , 0xFFfee8c8
                , 0xFFfdd49e
                , 0xFFfdbb84
                , 0xFFfc8d59
                , 0xFFef6548
                , 0xFFd7301f
                , 0xFFb30000
                , 0xFF7f0000
                , 0xFFfff7fb
                , 0xFFece7f2
                , 0xFFd0d1e6
                , 0xFFa6bddb
                , 0xFF74a9cf
                , 0xFF3690c0
                , 0xFF0570b0
                , 0xFF045a8d
                , 0xFF023858
                , 0xFFfff7fb
                , 0xFFece2f0
                , 0xFFd0d1e6
                , 0xFFa6bddb
                , 0xFF67a9cf
                , 0xFF3690c0
                , 0xFF02818a
                , 0xFF016c59
                , 0xFF014636
                , 0xFFf7f4f9
                , 0xFFe7e1ef
                , 0xFFd4b9da
                , 0xFFc994c7
                , 0xFFdf65b0
                , 0xFFe7298a
                , 0xFFce1256
                , 0xFF980043
                , 0xFF67001f
                , 0xFFfff7f3
                , 0xFFfde0dd
                , 0xFFfcc5c0
                , 0xFFfa9fb5
                , 0xFFf768a1
                , 0xFFdd3497
                , 0xFFae017e
                , 0xFF7a0177
                , 0xFF49006a
                , 0xFFffffe5
                , 0xFFf7fcb9
                , 0xFFd9f0a3
                , 0xFFaddd8e
                , 0xFF78c679
                , 0xFF41ab5d
                , 0xFF238443
                , 0xFF006837
                , 0xFF004529
                , 0xFFffffd9
                , 0xFFedf8b1
                , 0xFFc7e9b4
                , 0xFF7fcdbb
                , 0xFF41b6c4
                , 0xFF1d91c0
                , 0xFF225ea8
                , 0xFF253494
                , 0xFF081d58
                , 0xFFffffe5
                , 0xFFfff7bc
                , 0xFFfee391
                , 0xFFfec44f
                , 0xFFfe9929
                , 0xFFec7014
                , 0xFFcc4c02
                , 0xFF993404
                , 0xFF662506
                , 0xFFffffcc
                , 0xFFffeda0
                , 0xFFfed976
                , 0xFFfeb24c
                , 0xFFfd8d3c
                , 0xFFfc4e2a
                , 0xFFe31a1c
                , 0xFFbd0026
                , 0xFF800026
                // sequential single
                , 0xFFf7fbff
                , 0xFFdeebf7
                , 0xFFc6dbef
                , 0xFF9ecae1
                , 0xFF6baed6
                , 0xFF4292c6
                , 0xFF2171b5
                , 0xFF08519c
                , 0xFF08306b
                , 0xFFf7fcf5
                , 0xFFe5f5e0
                , 0xFFc7e9c0
                , 0xFFa1d99b
                , 0xFF74c476
                , 0xFF41ab5d
                , 0xFF238b45
                , 0xFF006d2c
                , 0xFF00441b
                , 0xFFffffff
                , 0xFFf0f0f0
                , 0xFFd9d9d9
                , 0xFFbdbdbd
                , 0xFF969696
                , 0xFF737373
                , 0xFF525252
                , 0xFF252525
                , 0xFF000000
                , 0xFFfff5eb
                , 0xFFfee6ce
                , 0xFFfdd0a2
                , 0xFFfdae6b
                , 0xFFfd8d3c
                , 0xFFf16913
                , 0xFFd94801
                , 0xFFa63603
                , 0xFF7f2704
                , 0xFFfcfbfd
                , 0xFFefedf5
                , 0xFFdadaeb
                , 0xFFbcbddc
                , 0xFF9e9ac8
                , 0xFF807dba
                , 0xFF6a51a3
                , 0xFF54278f
                , 0xFF3f007d
                , 0xFFfff5f0
                , 0xFFfee0d2
                , 0xFFfcbba1
                , 0xFFfc9272
                , 0xFFfb6a4a
                , 0xFFef3b2c
                , 0xFFcb181d
                , 0xFFa50f15
                , 0xFF67000d
                // diverging 19 in
                , 0xFF8c510a
                , 0xFFbf812d
                , 0xFFdfc27d
                , 0xFFf6e8c3
                , 0xFFf5f5f5
                , 0xFFc7eae5
                , 0xFF80cdc1
                , 0xFF35978f
                , 0xFF01665e
                , 0xFFc51b7d
                , 0xFFde77ae
                , 0xFFf1b6da
                , 0xFFfde0ef
                , 0xFFf7f7f7
                , 0xFFe6f5d0
                , 0xFFb8e186
                , 0xFF7fbc41
                , 0xFF4d9221
                , 0xFF762a83
                , 0xFF9970ab
                , 0xFFc2a5cf
                , 0xFFe7d4e8
                , 0xFFf7f7f7
                , 0xFFd9f0d3
                , 0xFFa6dba0
                , 0xFF5aae61
                , 0xFF1b7837
                , 0xFFb35806
                , 0xFFe08214
                , 0xFFfdb863
                , 0xFFfee0b6
                , 0xFFf7f7f7
                , 0xFFd8daeb
                , 0xFFb2abd2
                , 0xFF8073ac
                , 0xFF542788
                , 0xFFb2182b
                , 0xFFd6604d
                , 0xFFf4a582
                , 0xFFfddbc7
                , 0xFFf7f7f7
                , 0xFFd1e5f0
                , 0xfF92c5de
                , 0xFF4393c3
                , 0xFF2166ac
                , 0xFFb2182b
                , 0xFFd6604d
                , 0xFFf4a582
                , 0xFFfddbc7
                , 0xFFffffff
                , 0xFFe0e0e0
                , 0xFFbababa
                , 0xFF878787
                , 0xFF4d4d4d
                , 0xFFd73027
                , 0xFFf46d43
                , 0xFFfdae61
                , 0xFFfee090
                , 0xFFffffbf
                , 0xFFe0f3f8
                , 0xFFabd9e9
                , 0xFF74add1
                , 0xFF4575b4
                , 0xFFd73027
                , 0xFFf46d43
                , 0xFFfdae61
                , 0xFFfee08b
                , 0xFFffffbf
                , 0xFFd9ef8b
                , 0xFFa6d96a
                , 0xFF66bd63
                , 0xFF1a9850
                , 0xFFd53e4f
                , 0xFFf46d43
                , 0xFFfdae61
                , 0xFFfee08b
                , 0xFFffffbf
                , 0xFFe6f598
                , 0xFFabdda4
                , 0xFF66c2a5
                , 0xFF3288bd
                // quantitive
                , 0xFFa6cee3
                , 0xFF1f78b4
                , 0xFFb2df8a
                , 0xFF33a02c
                , 0xFFfb9a99
                , 0xFFe31a1c
                , 0xFFfdbf6f
                , 0xFFff7f00
                , 0xFFcab2d6
                , 0xFFfbb4ae
                , 0xFFb3cde3
                , 0xFFccebc5
                , 0xFFdecbe4
                , 0xFFfed9a6
                , 0xFFffffcc
                , 0xFFe5d8bd
                , 0xFFfddaec
                , 0xFFf2f2f2
                , 0xFFe41a1c
                , 0xFF377eb8
                , 0xFF4daf4a
                , 0xFF984ea3
                , 0xFFff7f00
                , 0xFFffff33
                , 0xFFa65628
                , 0xFFf781bf
                , 0xFF999999
                , 0xFF8dd3c7
                , 0xFFffffb3
                , 0xFFbebada
                , 0xFFfb8072
                , 0xFF80b1d3
                , 0xFFfdb462
                , 0xFFb3de69
                , 0xFFfccde5
                , 0xFFd9d9d9 ];
    }
// for targets that don't need alpha specified.
    public inline function RGB(){
                // real rainbow colors + black and white
        return [  0x000000 // black
                , 0xFF0000 // red
                , 0xFF7F00 // orange
                , 0xFFFF00 // yellow
                , 0x00ff00 // green
                , 0x0000FF // blue
                , 0x4b0082 // indigo
                , 0x9400D3 // violet
                , 0xFFFFFF // white
                // My hand created Rainbow Colors
                , 0xD2D0C1  
                , 0xCD8028
                , 0xD29D11
                , 0xE37128
                , 0xF06771
                , 0xD23931
                , 0xAF2C31
                , 0x90333E
                , 0x863D50
                
                , 0x584A5D
                , 0x549EC3
                , 0x2C709D
                , 0x457AAE
                , 0x364D6D
                , 0x378C6D
                , 0x6EA748
                , 0x365DA4
                , 0x456E42
                
                , 0xC1882E
                , 0x813424
                , 0x402E24
                , 0x292420
                , 0x525751
                , 0x1B1B19
        
                , 0x444444 // LightGrey
                , 0x333333 // MidGrey
                , 0x0c0c0c // DarkGrey  
                // sequential multi
                , 0xf7fcfd
                , 0xe5f5f9
                , 0xccece6
                , 0x99d8c9
                , 0x66c2a4
                , 0x41ae76
                , 0x238b45
                , 0x006d2c
                , 0x00441b
                , 0xf7fcfd
                , 0xe0ecf4
                , 0xbfd3e6
                , 0x9ebcda
                , 0x8c96c6
                , 0x8c6bb1
                , 0x88419d
                , 0x810f7c
                , 0x4d004b
                , 0xf7fcf0
                , 0xe0f3db
                , 0xccebc5
                , 0xa8ddb5
                , 0x7bccc4
                , 0x4eb3d3
                , 0x2b8cbe
                , 0x0868ac
                , 0x084081
                , 0xfff7ec
                , 0xfee8c8
                , 0xfdd49e
                , 0xfdbb84
                , 0xfc8d59
                , 0xef6548
                , 0xd7301f
                , 0xb30000
                , 0x7f0000
                , 0xfff7fb
                , 0xece7f2
                , 0xd0d1e6
                , 0xa6bddb
                , 0x74a9cf
                , 0x3690c0
                , 0x0570b0
                , 0x045a8d
                , 0x023858
                , 0xfff7fb
                , 0xece2f0
                , 0xd0d1e6
                , 0xa6bddb
                , 0x67a9cf
                , 0x3690c0
                , 0x02818a
                , 0x016c59
                , 0x014636
                , 0xf7f4f9
                , 0xe7e1ef
                , 0xd4b9da
                , 0xc994c7
                , 0xdf65b0
                , 0xe7298a
                , 0xce1256
                , 0x980043
                , 0x67001f
                , 0xfff7f3
                , 0xfde0dd
                , 0xfcc5c0
                , 0xfa9fb5
                , 0xf768a1
                , 0xdd3497
                , 0xae017e
                , 0x7a0177
                , 0x49006a
                , 0xffffe5
                , 0xf7fcb9
                , 0xd9f0a3
                , 0xaddd8e
                , 0x78c679
                , 0x41ab5d
                , 0x238443
                , 0x006837
                , 0x004529
                , 0xffffd9
                , 0xedf8b1
                , 0xc7e9b4
                , 0x7fcdbb
                , 0x41b6c4
                , 0x1d91c0
                , 0x225ea8
                , 0x253494
                , 0x081d58
                , 0xffffe5
                , 0xfff7bc
                , 0xfee391
                , 0xfec44f
                , 0xfe9929
                , 0xec7014
                , 0xcc4c02
                , 0x993404
                , 0x662506
                , 0xffffcc
                , 0xffeda0
                , 0xfed976
                , 0xfeb24c
                , 0xfd8d3c
                , 0xfc4e2a
                , 0xe31a1c
                , 0xbd0026
                , 0x800026
                // sequential single
                , 0xf7fbff
                , 0xdeebf7
                , 0xc6dbef
                , 0x9ecae1
                , 0x6baed6
                , 0x4292c6
                , 0x2171b5
                , 0x08519c
                , 0x08306b
                , 0xf7fcf5
                , 0xe5f5e0
                , 0xc7e9c0
                , 0xa1d99b
                , 0x74c476
                , 0x41ab5d
                , 0x238b45
                , 0x006d2c
                , 0x00441b
                , 0xffffff
                , 0xf0f0f0
                , 0xd9d9d9
                , 0xbdbdbd
                , 0x969696
                , 0x737373
                , 0x525252
                , 0x252525
                , 0x000000
                , 0xfff5eb
                , 0xfee6ce
                , 0xfdd0a2
                , 0xfdae6b
                , 0xfd8d3c
                , 0xf16913
                , 0xd94801
                , 0xa63603
                , 0x7f2704
                , 0xfcfbfd
                , 0xefedf5
                , 0xdadaeb
                , 0xbcbddc
                , 0x9e9ac8
                , 0x807dba
                , 0x6a51a3
                , 0x54278f
                , 0x3f007d
                , 0xfff5f0
                , 0xfee0d2
                , 0xfcbba1
                , 0xfc9272
                , 0xfb6a4a
                , 0xef3b2c
                , 0xcb181d
                , 0xa50f15
                , 0x67000d
                // diverging 19 in
                , 0x8c510a
                , 0xbf812d
                , 0xdfc27d
                , 0xf6e8c3
                , 0xf5f5f5
                , 0xc7eae5
                , 0x80cdc1
                , 0x35978f
                , 0x01665e
                , 0xc51b7d
                , 0xde77ae
                , 0xf1b6da
                , 0xfde0ef
                , 0xf7f7f7
                , 0xe6f5d0
                , 0xb8e186
                , 0x7fbc41
                , 0x4d9221
                , 0x762a83
                , 0x9970ab
                , 0xc2a5cf
                , 0xe7d4e8
                , 0xf7f7f7
                , 0xd9f0d3
                , 0xa6dba0
                , 0x5aae61
                , 0x1b7837
                , 0xb35806
                , 0xe08214
                , 0xfdb863
                , 0xfee0b6
                , 0xf7f7f7
                , 0xd8daeb
                , 0xb2abd2
                , 0x8073ac
                , 0x542788
                , 0xb2182b
                , 0xd6604d
                , 0xf4a582
                , 0xfddbc7
                , 0xf7f7f7
                , 0xd1e5f0
                , 0x92c5de
                , 0x4393c3
                , 0x2166ac
                , 0xb2182b
                , 0xd6604d
                , 0xf4a582
                , 0xfddbc7
                , 0xffffff
                , 0xe0e0e0
                , 0xbababa
                , 0x878787
                , 0x4d4d4d
                , 0xd73027
                , 0xf46d43
                , 0xfdae61
                , 0xfee090
                , 0xffffbf
                , 0xe0f3f8
                , 0xabd9e9
                , 0x74add1
                , 0x4575b4
                , 0xd73027
                , 0xf46d43
                , 0xfdae61
                , 0xfee08b
                , 0xffffbf
                , 0xd9ef8b
                , 0xa6d96a
                , 0x66bd63
                , 0x1a9850
                , 0xd53e4f
                , 0xf46d43
                , 0xfdae61
                , 0xfee08b
                , 0xffffbf
                , 0xe6f598
                , 0xabdda4
                , 0x66c2a5
                , 0x3288bd
                // quantitive
                , 0xa6cee3
                , 0x1f78b4
                , 0xb2df8a
                , 0x33a02c
                , 0xfb9a99
                , 0xe31a1c
                , 0xfdbf6f
                , 0xff7f00
                , 0xcab2d6
                , 0xfbb4ae
                , 0xb3cde3
                , 0xccebc5
                , 0xdecbe4
                , 0xfed9a6
                , 0xffffcc
                , 0xe5d8bd
                , 0xfddaec
                , 0xf2f2f2
                , 0xe41a1c
                , 0x377eb8
                , 0x4daf4a
                , 0x984ea3
                , 0xff7f00
                , 0xffff33
                , 0xa65628
                , 0xf781bf
                , 0x999999
                , 0x8dd3c7
                , 0xffffb3
                , 0xbebada
                , 0xfb8072
                , 0x80b1d3
                , 0xfdb462
                , 0xb3de69
                , 0xfccde5
                , 0xd9d9d9 ];
    }
    #end
}
