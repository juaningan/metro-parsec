! tabla de salida cuando no se obtiene resultado de una consulta

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
!*.xrtTblCellValues:            ./enconsulta.ascii
*.xrtTblBackgroundSeries:      (3-52 1-57 #FFE7CD)(0-2 all gray80)(all 58-59 gray80)
*.xrtTblForegroundSeries:      (all all brown)(0 all black)(1 all black)(2 all black)
*.xrtTblNumRows:               16
*.xrtTblNumColumns:            59
*.xrtTblFrozenRows:            3
*.xrtTblFrozenRowPlacement:    place_bottom
*.xrtTblSpanList:              (2,1 2,42)(0,1 0,57)(3,1 3,57) 
*.xrtTblPixelWidthSeries:      (all all 15)
*.xrtTblPixelHeightSeries:     (all all 22)(0 all 25)(1 all 20)(2 all 25)
*.xrtTblBorderTypeSeries:      (all all border_etched_in) 
*.xrtTblAllowCellResize:       RESIZE_NONE
*.xrtTblSelectionPolicy:       SELECT_NONE
*.xrtTblAlignmentSeries:       (all all ALIGNMENT_MIDDLEBEGIN)(3 all ALIGNMENT_MIDDLECENTER) \
                               (0 all ALIGNMENT_BOTTOMCENTER)(2 46 ALIGNMENT_BOTTOMCENTER)
*.xrtTblEditableSeries:        (ALL ALL False)
*.xrtTblTraversableSeries:     (ALL ALL False)
*.xrtTblFontListSeries: \
		    (all all -adobe-courier-medium-r-normal--12-120-75-75-m-70-iso8859-1) \
                    (0 all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) \
                    (2 all -b&h-lucida-bold-r-normal-sans-14-140-75-75-p-92-iso8859-1)
!*.xrtTblFontListSeries: \
!                    (all all -dt-application-bold-r-normal-serif-14-100-100-100-m-90-iso8859-1) \
!                    (0 all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) \
!                    (2 all -b&h-lucida-bold-r-normal-sans-14-140-75-75-p-92-iso8859-1)
*.xrtTblShadowThickness:       2
*.xrtTblShadowType:       shadow_out
*.xrtTblDisplayClipArrows:     False
*.xrtTblMarginWidth:           0
*.xrtTblMarginHeight:          0
*.xrtTblDisplayHorizScrollBar:     DISPSB_NEVER
*.xrtTblDisplayVertScrollBar:     DISPSB_NEVER
!*.xrtTblBorderSidesSeries:     (all all BORDERSIDE_ALL)
*.xrtTblBorderSidesSeries:     (all all BORDERSIDE_NONE) 
*.xrtTblTrackCursor:          False
                               
                               