!tabla que se carga cuando se pincha sobre ESTADO CAJA
titles: title
! SGI converter can't handle whitespace in fontlist, so give up nice formatting
*.title.fontList: \
	          -b&h-lucida-bold-r-normal-sans-18-180-75-75-p-120-iso8859-1
!*.title.fontList: \
!	-*-new century schoolbook-bold-r-normal-*-240-*iso8859-1=R,-*-new century schoolbook-bold-i-normal-*-240-*iso8859-1=I,-*-new century schoolbook-bold-r-normal-*-240-*iso8859-1=B,-*-symbol-medium-r-normal-*-240-*=S
*.title.labelString: @R@ESTADO CAJA@P@
*.title.foreground:         black
*.title.xrtLblBorderType:   BORDER_NONE
*.title.xrtTblLocation:     LOCATION_TOP
*.title.xrtTblTopOffset:    5
*.title.xrtTblBottomOffset: 5

! Table
*.background:                  gray80
!*.xrtTblCellValues:            estado.ascii
! SGI converter can't handle whitespace in fontlist, so give up nice formatting
*.xrtTblFontListSeries: \
                    (all all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) 
!*.xrtTblFontListSeries: (all all -*-helvetica-bold-r-normal-*-140-*iso8859-1)
*.xrtTblBackgroundSeries:      (all all gray80)(0-3 15 gray90)(0 49 gray90)
*.xrtTblForegroundSeries:      (all all black)(5 all brown)(9-12 all blue)
*.xrtTblPixelWidthSeries:      (all all 14)
*.xrtTblPixelHeightSeries:     (all all 30)(4 all 10)(5 all 25)(7 all 25)(8 all 25)(6 all 15)(9-12 all 23)
*.xrtTblBorderTypeSeries:      (all all border_out)(0-5 all border_in) 
*.xrtTblShadowThickness:       2
*.xrtTblFrameShadowThickness:  0
*.xrtTblMarginWidth:           0
*.xrtTblMarginHeight:          2
*.xrtTblNumRows:               13
*.xrtTblNumColumns:            60
*.xrtTblFrozenRows:            8
*.xrtTblFrozenRowPlacement:    place_top
*.xrtTblAlignmentSeries:       (ALL ALL ALIGNMENT_MIDDLECENTER)(0-3 ALL ALIGNMENT_MIDDLEBEGIN)(9-12 26 ALIGNMENT_MIDDLEBEGIN) 
*.xrtTblEditableSeries:        (ALL ALL False)
*.xrtTblTraversableSeries:     (ALL ALL False)
*.xrtTblAllowCellResize:       RESIZE_NONE
*.xrtTblSelectionPolicy:       SELECT_NONE
*.xrtTblBorderSidesSeries:     (ALL ALL BORDERSIDE_ALL)(8 ALL BORDERSIDE_NONE) \
                               (8 ALL BORDERSIDE_NONE)(4 ALL BORDERSIDE_NONE) \
                               (5 ALL BORDERSIDE_NONE)(0 0-14 BORDERSIDE_NONE) \
                               (0 24-48 BORDERSIDE_NONE)(0 56-59 BORDERSIDE_NONE) \
                               (1 0-6 BORDERSIDE_NONE)(1 21-59 BORDERSIDE_NONE) \
                               (2 0-6 BORDERSIDE_NONE)(2 48-59 BORDERSIDE_NONE) \
                               (3 0-6 BORDERSIDE_NONE)(3 35-59 BORDERSIDE_NONE) \
                               (6 ALL BORDERSIDE_NONE)(7 ALL BORDERSIDE_NONE) \
                               (8-12 ALL BORDERSIDE_NONE)(8 9-50 BORDERSIDE_BOTTOM)
!*.xrtTblBorderSidesSeries:     (ALL ALL BORDERSIDE_ALL)
*.xrtTblTrackCursor:           False
*.xrtTblDisplayClipArrows:     False
*.xrtTblDisplayHorizScrollBar:     DISPSB_NEVER
