! tabla de salida cuando se pincha en Consulta

titles: title
*.title.fontList: \
	          -b&h-lucida-bold-r-normal-sans-18-180-75-75-p-120-iso8859-1
*.title.labelString: @R@CONSULTA ESTACION@P@
*.title.foreground:         black
*.title.xrtLblBorderType:   BORDER_NONE
*.title.xrtTblLocation:     LOCATION_TOP
*.title.xrtTblTopOffset:    0
*.title.xrtTblBottomOffset: 5

! Table
*.background:                  gray80
!*.xrtTblCellValues:            ./consulta.ascii
*.xrtTblBackgroundSeries:      (all all #FFE7CD)(all 0 gray80)(all 58-59 gray80)(0-2 all gray80) \
                               (2 10 gray90)(2 26 gray90)(2 37-42 #5BB761)(2 46-51 #5BB761)
*.xrtTblForegroundSeries:      (all all Midnight Blue)(0-2 all black) 
*.xrtTblNumRows:               53
*.xrtTblNumColumns:            60
*.xrtTblFrozenRows:            3
*.xrtTblFrozenRowPlacement:    place_bottom
*.xrtTblPixelWidthSeries:      (all all 15)
*.xrtTblPixelHeightSeries:     (all all 22)(0 all 25)(1 all 20)(2 all 25)
*.xrtTblBorderTypeSeries:      (all all border_etched_in)(2 all border_in)
*.xrtTblAllowCellResize:       RESIZE_NONE
*.xrtTblSelectionPolicy:       SELECT_NONE
*.xrtTblAlignmentSeries:       (all all ALIGNMENT_MIDDLEBEGIN)(0 all ALIGNMENT_BOTTOMCENTER) \
                               (2 37 ALIGNMENT_BOTTOMCENTER)(2 46 ALIGNMENT_BOTTOMCENTER) \
                               (2 10 ALIGNMENT_MIDDLECENTER)(2 26 ALIGNMENT_MIDDLECENTER) \
                               (2 1 ALIGNMENT_BOTTOMEND)(2 18 ALIGNMENT_BOTTOMEND)
*.xrtTblEditableSeries:        (ALL ALL False)(2 10 True)(2 26 True)
*.xrtTblTraversableSeries:     (ALL ALL False)(2 10 True)(2 26 True)
!*.xrtTblFontListSeries: \
!                    (all all -dt-application-bold-r-normal-serif-14-100-100-100-m-90-iso8859-1) \
!                    (0 all --schumacher-clean-bold-r-normal--12-120-75-75-c-80-iso8859-1) \
!                    (2 all -b&h-lucida-bold-r-normal-sans-14-140-75-75-p-92-iso8859-1) \
!                    (2 10 -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) \
!                    (all 26 -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) 
!                    (0 all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) 
*.xrtTblFontListSeries: \
	            (all all -adobe-courier-medium-r-normal--12-120-75-75-m-70-iso8859-1) \
                    (0 all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) \
                    (2 all -b&h-lucida-bold-r-normal-sans-14-140-75-75-p-92-iso8859-1) \
                    (2 10 -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) \
                    (2 26 -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) 
*.xrtTblShadowThickness:       2
*.xrtTblShadowType:       shadow_out
*.xrtTblDisplayClipArrows:     False
*.xrtTblMarginWidth:           0
*.xrtTblMarginHeight:          0
*.xrtTblDisplayHorizScrollBar:     DISPSB_NEVER
!*.xrtTblBorderSidesSeries:     (all all BORDERSIDE_ALL)
*.xrtTblBorderSidesSeries:     (all all BORDERSIDE_NONE)(2 10 BORDERSIDE_ALL) \
                               (2 26 BORDERSIDE_ALL)(2 37-42 BORDERSIDE_ALL)(2 46-51 BORDERSIDE_ALL)
*.xrtTblTrackCursor:          False
