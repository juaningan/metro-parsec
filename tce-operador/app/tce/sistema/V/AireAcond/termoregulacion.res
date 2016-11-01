!tabla que se carga cuando se pincha sobre parametros de termoregulacion
titles: title
! SGI converter can't handle whitespace in fontlist, so give up nice formatting
*.title.fontList: \
	          -b&h-lucida-bold-r-normal-sans-18-180-75-75-p-120-iso8859-1
!*.title.fontList: \
!	-*-new century schoolbook-bold-r-normal-*-240-*iso8859-1=R,-*-new century schoolbook-bold-i-normal-*-240-*iso8859-1=I,-*-new century schoolbook-bold-r-normal-*-240-*iso8859-1=B,-*-symbol-medium-r-normal-*-240-*=S
*.title.labelString: @R@PARAMETROS DE TERMOREGULACION@P@
*.title.foreground:         black
*.title.xrtLblBorderType:   BORDER_NONE
*.title.xrtTblLocation:     LOCATION_TOP
*.title.xrtTblTopOffset:    5
*.title.xrtTblBottomOffset: 5

! Table
*.background:                  gray80

! Carga el mismo ascii que etados xq solo cambian los botones
*.xrtTblCellValues:            termoregulacion.ascii

*.xrtTblFontListSeries: (all all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1)
*.xrtTblBackgroundSeries:      (all all gray80)(0 11 gray90)(0 28 gray90)(0 52 gray90) \
                               (2 24 gray90)(2 55 gray90) \
                               (4 24 gray90)(4 55 gray90)(6 24 gray90)(6 55 gray90)(8 24 gray90)(8 55 gray90) \
                               (10 24 gray90)(10 55 gray90)(12 24 gray90)(12 55 gray90)
*.xrtTblForegroundSeries:      (all all black)(15 all white)
*.xrtTblPixelWidthSeries:      (all all 14)
*.xrtTblPixelHeightSeries:     (all all 21)(1 all 14)(3 all 7)(5 all 7)(7 all 7)(9 all 7)(11 all 7)(14 all 82)(15 all 30)
*.xrtTblBorderTypeSeries:      (all all border_in)(15 all border_etched_in) 
*.xrtTblShadowThickness:       2
*.xrtTblHighlightThickness:       0
*.xrtTblHighlightColor:       #739acd
*.xrtTblBottomShadowColor:       #3f4a55
*.xrtTblTopShadowColor:       #c3ccd5
*.xrtTblHighlightColor:       #739acd
*.xrtTblFrameShadowThickness:  0
*.xrtTblMarginWidth:           0
*.xrtTblMarginHeight:          0
*.xrtTblNumRows:               16
*.xrtTblNumColumns:            64
*.xrtTblAlignmentSeries:       (ALL ALL ALIGNMENT_MIDDLECENTER)(0 44 ALIGNMENT_MIDDLEBEGIN) \
                               (ALL 34 ALIGNMENT_MIDDLEBEGIN)(ALL 28 ALIGNMENT_MIDDLEBEGIN) \
                               (ALL 3 ALIGNMENT_MIDDLEBEGIN)(0 28 ALIGNMENT_MIDDLECENTER)(ALL 59 ALIGNMENT_MIDDLEBEGIN)
*.xrtTblEditableSeries:        (ALL ALL False)(2 24 True)(2 55 True)(4 24 True)(4 55 True) \
                               (6 24 True)(6 55 True)(8 24 True)(8 55 True)(10 24 True)(10 55 True)(12 24 True)(12 55 True)
*.xrtTblTraversableSeries:     (ALL ALL False)(2 24 True)(2 55 True)(4 24 True)(4 55 True) \
                               (6 24 True)(6 55 True)(8 24 True)(8 55 True)(10 24 True)(10 55 True)(12 24 True)(12 55 True)
*.xrtTblAllowCellResize:       RESIZE_NONE
*.xrtTblSelectionPolicy:       SELECT_NONE
*.xrtTblBorderSidesSeries:     (ALL ALL BORDERSIDE_ALL)
*.xrtTblBorderSidesSeries:     (ALL ALL BORDERSIDE_NONE)(0 11 BORDERSIDE_ALL)(0 28 BORDERSIDE_ALL)(0 52 BORDERSIDE_ALL) \
                                (2 24 BORDERSIDE_ALL)(2 55 BORDERSIDE_ALL)(4 24 BORDERSIDE_ALL)(4 55 BORDERSIDE_ALL) \
                                (6 24 BORDERSIDE_ALL)(6 55 BORDERSIDE_ALL)(8 24 BORDERSIDE_ALL)(8 55 BORDERSIDE_ALL) \
                                (10 24 BORDERSIDE_ALL)(10 55 BORDERSIDE_ALL)(12 24 BORDERSIDE_ALL)(12 55 BORDERSIDE_ALL)
*.xrtTblTrackCursor:           False
*.xrtTblDisplayClipArrows:     False
*.xrtTblDisplayHorizScrollBar:     DISPSB_NEVER
*.xrtTblSpanList:     (0,3 0,10)(0,11 0,18)(0,23 0,27)(0,28 0,39)(0,44 0,51)(0,52 0,60) \
                      (1,0 1,30)(1,33 1,63) \
                      (2,3 2,23)(2,24 2,26)(2,28 2,29)(2,34 2,54)(2,55 2,57)(2,59 2,60) \
                      (4,3 4,23)(4,24 4,26)(4,28 4,29)(4,34 4,54)(4,55 4,57)(4,59 4,60) \
                      (6,3 6,23)(6,24 6,26)(6,28 6,29)(6,34 6,54)(6,55 6,57)(6,59 6,60) \
                      (8,3 8,23)(8,24 8,26)(8,28 8,29)(8,34 8,54)(8,55 8,57)(8,59 8,60) \
                      (10,3 10,23)(10,24 10,26)(10,28 10,29)(10,34 10,54)(10,55 10,57)(10,59 10,60) \
                      (12,3 12,23)(12,24 12,26)(12,28 12,29)(12,34 12,54)(12,55 12,57)(12,59 12,60) \
                      (15,20 15,25)(15,38 15,43)
                      