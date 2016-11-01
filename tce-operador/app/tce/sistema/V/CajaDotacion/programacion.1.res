! tabla de salida cuando se pincha en BORRAR PERIODO

titles: title
*.title.fontList: \
	          -b&h-lucida-bold-r-normal-sans-18-180-75-75-p-120-iso8859-1

*.title.labelString: @R@ESTADO PROGRAMACION@P@
*.title.foreground:         black
*.title.xrtLblBorderType:   BORDER_NONE
*.title.xrtTblLocation:     LOCATION_TOP
*.title.xrtTblRightOffset:    200
*.title.xrtTblBottomOffset: 13
*.title.xrtTblTopOffset: 0

! Table
*.background:                  gray80
*.xrtLblBorderType:            BORDER_IN
!*.xrtTblCellValues:            ./programacion.1.ascii
*.xrtTblFontListSeries: \
                    (all all -b&h-lucida-bold-r-normal-sans-12-120-75-75-p-79-iso8859-1) \
                    (label all -b&h-lucida-bold-r-normal-sans-14-140-75-75-p-92-iso8859-1)
*.xrtTblColumnLabels:          ,,,,,,CODIGO,,,,TIPO,,,,,,,,,,ACTIVO,,,,,,,,,HORA INICIO,,,,,,,HORA FIN
*.xrtTblBackgroundSeries:      (all all gray80)(label all #677a8d)(label 0-5 gray80) \
                               (4-39 6-42 gray90)(3 15-19 #768ca1)(3 29-33 #768ca1)(1 31 gray90) 
*.xrtTblForegroundSeries:      (all all black)(label all white)(1 all brown) \
                               (3 15 white)(3 29 white)
*.xrtTblPixelWidthSeries:      (all all 18) 
*.xrtTblPixelHeightSeries:     (all all 19)(0 all 12)(1 all 25)(2 all 15)(3 all 25)
*.xrtTblBorderTypeSeries:      (all all border_out)(1 all border_in) 
*.xrtTblShadowThickness:       2
*.xrtTblShadowType:            shadow_out
*.xrtTblColumnLabelOffset:     0
*.xrtTblFrameShadowType:       border_etched_in
*.xrtTblMarginWidth:           2
*.xrtTblMarginHeight:          0
*.xrtTblNumRows:               40
*.xrtTblNumColumns:            43
*.xrtTblAlignmentSeries:       (all all ALIGNMENT_MIDDLECENTER)(1 all ALIGNMENT_BOTTOMCENTER)(1 31 ALIGNMENT_MIDDLECENTER)
*.xrtTblEditableSeries:        (ALL ALL False)(1 31 True) 
*.xrtTblTraversableSeries:     (ALL ALL False)(1 31 True) 
*.xrtTblAllowCellResize:       RESIZE_NONE
*.xrtTblSelectionPolicy:       SELECT_NONE
*.xrtTblBorderSidesSeries:     (ALL ALL BORDERSIDE_ALL)(1-43 0-5 BORDERSIDE_NONE) \
                               (1 ALL BORDERSIDE_NONE)(1 31 BORDERSIDE_ALL) \
                               (label 0-5 BORDERSIDE_NONE)(0 ALL BORDERSIDE_NONE) \
                               (2 ALL BORDERSIDE_NONE)(3 ALL BORDERSIDE_NONE) \
                               (3 15-19 BORDERSIDE_ALL)(3 29-33 BORDERSIDE_ALL)
*.xrtTblVertScrollBarBottomAttachment:     ATTACH_CELLS
*.xrtTblDisplayHorizScrollBar:             DISPSB_NEVER
*.xrtTblTrackCursor:                       False
*.xrtTblDisplayClipArrows:                 False
*.xrtTblFrozenRows:                        4
*.xrtTblFrozenRowPlacement:                place_bottom
*.xrtTblSpanList:              (label,6 label,9)(label,10 label,19)(label,20 label,28)(label,29 label,35)(label,36 label,43) \
                               (4,6 4,9)(4,10 4,19)(4,20 4,28)(4,29 4,35)(4,36 4,43) \
                               (5,6 5,9)(5,10 5,19)(5,20 5,28)(5,29 5,35)(5,36 5,43) \
                               (6,6 6,9)(6,10 6,19)(6,20 6,28)(6,29 6,35)(6,36 6,43) \
                               (7,6 7,9)(7,10 7,19)(7,20 7,28)(7,29 7,35)(7,36 7,43) \
                               (8,6 8,9)(8,10 8,19)(8,20 8,28)(8,29 8,35)(8,36 8,43) \
                               (9,6 9,9)(9,10 9,19)(9,20 9,28)(9,29 9,35)(9,36 9,43) \
                               (10,6 10,9)(10,10 10,19)(10,20 10,28)(10,29 10,35)(10,36 10,43) \
                               (11,6 11,9)(11,10 11,19)(11,20 11,28)(11,29 11,35)(11,36 11,43) \
                               (12,6 12,9)(12,10 12,19)(12,20 12,28)(12,29 12,35)(12,36 12,43) \
                               (13,6 13,9)(13,10 13,19)(13,20 13,28)(13,29 13,35)(13,36 13,43) \
                               (14,6 14,9)(14,10 14,19)(14,20 14,28)(14,29 14,35)(14,36 14,43) \
                               (15,6 15,9)(15,10 15,19)(15,20 15,28)(15,29 15,35)(15,36 15,43) \
                               (16,6 16,9)(16,10 16,19)(16,20 16,28)(16,29 16,35)(16,36 16,43) \
                               (17,6 17,9)(17,10 17,19)(17,20 17,28)(17,29 17,35)(17,36 17,43) \
                               (18,6 18,9)(18,10 18,19)(18,20 18,28)(18,29 18,35)(18,36 18,43) \
                               (19,6 19,9)(19,10 19,19)(19,20 19,28)(19,29 19,35)(19,36 19,43) \
                               (20,6 20,9)(20,10 20,19)(20,20 20,28)(20,29 20,35)(20,36 20,43) \
                               (21,6 21,9)(21,10 21,19)(21,20 21,28)(21,29 21,35)(21,36 21,43) \
                               (22,6 22,9)(22,10 22,19)(22,20 22,28)(22,29 22,35)(22,36 22,43) \
                               (23,6 23,9)(23,10 23,19)(23,20 23,28)(23,29 23,35)(23,36 23,43) \
                               (24 6-9) \ (24 10-19) \ (24 20-28) \ (24 29-35) \ (24 36-43) \
                               (25 6-9) \ (25 10-19) \ (25 20-28) \ (25 29-35) \ (25 36-43) \
                               (26 6-9) \ (26 10-19) \ (26 20-28) \ (26 29-35) \ (26 36-43) \
                               (27 6-9) \ (27 10-19) \ (27 20-28) \ (27 29-35) \ (27 36-43) \
                               (28 6-9) \ (28 10-19) \ (28 20-28) \ (28 29-35) \ (28 36-43) \
                               (29 6-9) \ (29 10-19) \ (29 20-28) \ (29 29-35) \ (29 36-43) \
                               (30 6-9) \ (30 10-19) \ (30 20-28) \ (30 29-35) \ (30 36-43) \
                               (31 6-9) \ (31 10-19) \ (31 20-28) \ (31 29-35) \ (31 36-43) \
                               (32 6-9) \ (32 10-19) \ (32 20-28) \ (32 29-35) \ (32 36-43) \
                               (33 6-9) \ (33 10-19) \ (33 20-28) \ (33 29-35) \ (33 36-43) \
                               (34 6-9) \ (34 10-19) \ (34 20-28) \ (34 29-35) \ (34 36-43) \
                               (35 6-9) \ (35 10-19) \ (35 20-28) \ (35 29-35) \ (35 36-43) \
                               (36 6-9) \ (36 10-19) \ (36 20-28) \ (36 29-35) \ (36 36-43) \
                               (37 6-9) \ (37 10-19) \ (37 20-28) \ (37 29-35) \ (37 36-43) \
                               (38 6-9) \ (38 10-19) \ (38 20-28) \ (38 29-35) \ (38 36-43) \
                               (39 6-9) \ (39 10-19) \ (39 20-28) \ (39 29-35) \ (39 36-43) \
                               (1,6 1,12) \ (1,15 1,28)(1,31 1,33) \
                               (3,15 3,19)(3,29 3,33)
                               
                               