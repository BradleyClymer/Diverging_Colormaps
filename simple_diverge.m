function [ map ] = simple_diverge( map_num , num_points ) 
%%  Parse input arguments, default missing ones
    if nargin < 2 
        num_points = 256                            ;
    end
    
    if nargin < 1 
        map_num     = 1                             ;
        point_vec   = 256                           ;
    end
    
figure_pos  = [ 1.1 0.2 0.8 0.6 ]                   ;

%%  Declare constants for colormaps
starts      = { [ 0.230, 0.299, 0.754 ]  
                [ 0.436, 0.308, 0.631 ]
                [ 0.085, 0.532, 0.201 ]
                [ 0.217, 0.525, 0.910 ]
                [ 0.085, 0.532, 0.201 ] }           ;

ends        = { [ 0.706, 0.016, 0.150 ]
                [ 0.759, 0.334, 0.046 ]
                [ 0.436, 0.308, 0.631 ]
                [ 0.677, 0.492, 0.093 ]
                [ 0.758, 0.214, 0.233 ] }           ;

names       = {   'Blue / Red'
                'Purple / Orange'
                 'Green / Purple'
                  'Blue / Tan'
                 'Green / Red'           }          ;

%%  Produce actual maps             
point_vec   = linspace( 0 , 1 , num_points )        ;
             
map_list    = struct( 'start' , starts ,            ...
                      'end'   , ends   ,            ...
                      'name'  , names  )            ;

map         = diverging_map( point_vec , map_list( map_num ).start , map_list( map_num ).end )      ;

%%  Main function complete. If user passes no arguments, produce a demo.
%   Demo requires export_fig and tightfig to work properly.
    if nargin == 0 
        whitebg
        load penny.mat
        D               = -del2( P )                                    ;
        for i_map = 1 : numel( map_list )
            h.fig( i_map )      = figure( 'Units' , 'Normalized' , 'OuterPosition' , figure_pos )                   ;
            subplot( 121 ) ,      contour( P , 15 )
                                  title( map_list( i_map ).name )
                                  axis ij square
                                  shading flat
                                  set( gca , 'XTick' , [] , 'YTick' , [] )
            subplot( 122 ) ,      imagesc( P )
                                  title( map_list( i_map ).name )
                                  set( gca , 'XTick' , [] , 'YTick' , [] )

            new_map{ i_map }    = diverging_map( point_vec , map_list( i_map ).start , map_list( i_map ).end )      ;
                                  colormap( new_map{ i_map } )                                                      ;         
            axis ij square
            shading flat
            objs                = findobj( allchild( h.fig( i_map ) ) , 'LineSmoothing' , 'off' )                   ;    
            set( objs , 'LineSmoothing' , 'on' , 'LineWidth' , 2 )
            
            try 
                tightfig 
            catch err_tight 
            end
            
            set( h.fig( i_map ) , 'Units' , 'Normalized' , 'OuterPosition' , figure_pos ) 
            drawnow
            
            try
            file_title  = [ map_list( i_map ).name '.pdf' ]                                                         ;
            file_title( file_title == '/' ) = '-'                                                                   ;
            export_fig( file_title )                                                                                ;
            catch err 
                disp( err )
            end
            whitebg
        end
    end
end