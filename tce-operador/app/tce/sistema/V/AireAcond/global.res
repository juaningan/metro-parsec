!tabla que se carga cuando se pincha sobre ESTADO GLOBAL
titles: title
! SGI converter can't handle whitespace in fontlist, so give up nice formatting
*.title.fontList: \
	          -b&h-lucida-bold-r-normal-sans-18-180-75-75-p-120-iso8859-1
!*.title.fontList: \
!	-*-new century schoolbook-bold-r-normal-*-240-*iso8859-1=R,-*-new century schoolbook-bold-i-normal-*-240-*iso8859-1=I,-*-new century schoolbook-bold-r-normal-*-240-*iso8859-1=B,-*-symbol-medium-r-normal-*-240-*=S
*.title.labelString: @R@ESTADO GLOBAL@P@
*.title.foreground:         black
*.title.xrtLblBorderType:   BORDER_NONE
*.title.xrtTblLocation:     LOCATION_TOP
*.title.xrtTblTopOffset:    5
*.title.xrtTblBottomOffset: 5
*.title.xrtTblRightOffset:    340

! Table
*.background:                  gray80
*.xrtTblCellValues:            global.ascii
! SGI converter can't handle whitespace in fontlist, so give up nice formatting
*.xrtTblFontListSeries: \
                    (all all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) 
!*.xrtTblFontListSeries: (all all -*-helvetica-bold-r-normal-*-140-*iso8859-1)
*.xrtTblBackgroundSeries:      (all all gray80) \
                               (0 11 gray90)(0 28 gray90)(0 52 gray90)
*.xrtTblForegroundSeries:      (all all red)(0-9 all black)(4 all brown)(6 all white)
*.xrtTblPixelWidthSeries:      (all all 14)
!*.xrtTblPixelHeightSeries:     (all all 22)
!*.xrtTblPixelHeightSeries:     (all all 22)(6 all 30)
*.xrtTblPixelHeightSeries:     (all all 22)(0-5 all 21)(6 all 30)(7-9 all 21)
*.xrtTblBorderTypeSeries:      (all all border_out)(0 all border_in)
*.xrtTblShadowThickness:       2
*.xrtTblFrameShadowThickness: 0
*.xrtTblMarginWidth:           0
*.xrtTblMarginHeight:          0
*.xrtTblNumRows:               25
*.xrtTblNumRows:               15
*.xrtTblNumColumns:            63
*.xrtTblFrozenColumns:         3
*.xrtTblFrozenColumnsPlacement:    place_left
*.xrtTblFrozenRows:            10
*.xrtTblFrozenRowPlacement:    place_top
*.xrtTblAlignmentSeries:       (ALL ALL ALIGNMENT_MIDDLECENTER) \
                               (0 3 ALIGNMENT_MIDDLEBEGIN) \
                               (0 44 ALIGNMENT_MIDDLEBEGIN) \
                               (ALL 28 ALIGNMENT_MIDDLEBEGIN) \
                               (0 28 ALIGNMENT_MIDDLECENTER) 
*.xrtTblEditableSeries:        (ALL ALL False)
*.xrtTblTraversableSeries:     (ALL ALL False)
*.xrtTblAllowCellResize:       RESIZE_NONE
*.xrtTblSelectionPolicy:       SELECT_NONE
*.xrtTblBorderSidesSeries:     (ALL ALL BORDERSIDE_NONE) \
                               (0 11 BORDERSIDE_ALL) \
                               (0 28 BORDERSIDE_ALL) \
                               (0 52 BORDERSIDE_ALL) \
                               (9 11 BORDERSIDE_BOTTOM)
!*.xrtTblBorderSidesSeries:     (ALL ALL BORDERSIDE_ALL) 
*.xrtTblTrackCursor:           False
*.xrtTblDisplayClipArrows:     False
*.xrtTblSpanList:              (0,3 0,10)(0,11 0,18)(0,23 0,27)(0,28 0,39)(0,44 0,51)(0,52 0,60) \
                               (4,3 4,60)(9,11 9,53)
*.xrtTblDisplayHorizScrollBar:     DISPSB_NEVER
