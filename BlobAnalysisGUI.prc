HEADER
; IDL Visual Widget Builder Resource file. Version 1
; Generated on:	08/14/2013 14:14.17
VERSION 1
END

WID_BASE_0 BASE 5 5 1343 887
TLB
CAPTION "IDL"
XPAD = 3
YPAD = 3
SPACE = 3
BEGIN
  WID_TAB_0 TAB 0 0 1329 850
  BEGIN
    WID_BASE_2 BASE 0 0 1321 824
    XPAD = 3
    YPAD = 3
    SPACE = 3
    CAPTION "Parameters/Preview"
    BEGIN
      WID_DRAW_0 DRAW 509 2 778 800
      FRAME = 1
      SCROLLWIDTH = 1000
      SCROLLHEIGHT = 1000
      END
      WID_LABEL_1 LABEL 6 1 498 30
      VALUE "Use this frame to preview data for analysis.  Load a desired file and adjust parameters until Blob Analysis is working correctly, then proceed to full analysis run."
      FRAME = 1
      ALIGNCENTER
      END
      WID_LABEL_2 LABEL 8 169 114 15
      VALUE "Unsharp Mask Radius:"
      ALIGNLEFT
      END
      WID_LABEL_3 LABEL 8 201 124 15
      VALUE "Threshold Value (0-255):"
      ALIGNLEFT
      END
      WID_BUTTON_1 PUSHBUTTON 399 136 93 27
      VALUE "Show Original"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnShowOriginal"
      END
      WID_BUTTON_2 PUSHBUTTON 399 206 93 27
      VALUE "Show OpenImage"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnShowOpenImage"
      END
      WID_BUTTON_3 PUSHBUTTON 399 241 93 27
      VALUE "Show Blobs"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnShowMask"
      END
      WID_TEXT_2 TEXT 134 196 50 20
      NUMITEMS = 1
      ITEM "150"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_4 LABEL 8 227 115 15
      VALUE "Smoothing Kernel Size:"
      ALIGNLEFT
      END
      WID_BUTTON_5 PUSHBUTTON 7 300 369 35
      VALUE "ANALYZE! (Results Shown Below)"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnAnalyzePreview"
      END
      WID_BUTTON_6 PUSHBUTTON 399 311 93 27
      VALUE "Show All"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnShowAll"
      END
      WID_BUTTON_7 PUSHBUTTON 399 171 93 27
      VALUE "Show Unsharp"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnShowUnsharp"
      END
      WID_BUTTON_8 PUSHBUTTON 399 276 93 27
      VALUE "Show Overlay"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnShowOverlay"
      END
      WID_BASE_5 BASE 6 132 141 27
      COLUMNS = 1
      NONEXCLUSIVE
      CAPTION "IDL"
      BEGIN
        WID_BUTTON_10 PUSHBUTTON -1 -1 139 24
        VALUE "Reverse Wedge Factor"
        ALIGNLEFT
        TOOLTIP "Reverses wedge factor to make sure holes are low"
        END
        WID_BUTTON_18 PUSHBUTTON -1 -1 0 0
        VALUE "Reverse Wedge Factor"
        ALIGNLEFT
        TOOLTIP "Reverses wedge factor to make sure holes are low"
        END
      END
      WID_LABEL_5 LABEL 186 270 27 18
      VALUE "Min:"
      ALIGNLEFT
      END
      WID_LABEL_6 LABEL 8 265 95 18
      VALUE "# of Measurements:"
      ALIGNLEFT
      END
      WID_LABEL_7 LABEL 207 242 95 18
      VALUE "Global Max Value:"
      ALIGNLEFT
      END
      WID_LABEL_8 LABEL 266 269 31 18
      VALUE "Max:"
      ALIGNLEFT
      END
      WID_TEXT_4 TEXT 213 268 46 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_6 TEXT 108 263 46 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_7 TEXT 297 268 46 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_8 TEXT 297 240 46 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_1 TEXT 134 165 50 20
      NUMITEMS = 1
      ITEM "10"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_3 TEXT 134 225 50 20
      NUMITEMS = 1
      ITEM "3"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_BASE_6 BASE 162 132 0 0
      COLUMNS = 1
      NONEXCLUSIVE
      CAPTION "IDL"
      BEGIN
        WID_BUTTON_19 PUSHBUTTON -1 -1 0 0
        VALUE "Subtract Reference Mode"
        ALIGNLEFT
        END
      END
      WID_BUTTON_21 PUSHBUTTON 5 34 128 38
      VALUE "Select Files"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "SelectMultipleFiles"
      END
      WID_BUTTON_20 PUSHBUTTON 145 37 72 34
      VALUE "Show Current"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnShowPreview"
      END
      WID_BUTTON_22 PUSHBUTTON 235 37 72 34
      VALUE "Back"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnBack"
      END
      WID_BUTTON_23 PUSHBUTTON 311 37 72 34
      VALUE "Next"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnNext"
      END
      WID_TEXT_0 TEXT 87 80 417 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_24 TEXT 439 42 63 24
      NUMITEMS = 1
      ITEM "1"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_32 LABEL 386 46 53 18
      VALUE "FileNum"
      ALIGNLEFT
      END
      WID_LABEL_33 LABEL 4 80 86 18
      VALUE "CurrentFileName"
      ALIGNLEFT
      END
      WID_TEXT_25 TEXT 87 109 417 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_34 LABEL 0 110 86 18
      VALUE "ReferenceFileName"
      ALIGNLEFT
      END
      WID_BUTTON_11 PUSHBUTTON 202 166 147 31
      VALUE "Set Current # as Reference"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnSetReference"
      END
      WID_BUTTON_24 PUSHBUTTON 202 206 147 31
      VALUE "Set Scale with Last Meas"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "OnSetScale"
      END
      WID_DRAW_1 DRAW 7 403 480 177
      END
      WID_TEXT_12 TEXT 334 375 40 20
      NUMITEMS = 1
      ITEM "6"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_11 TEXT 203 375 40 20
      NUMITEMS = 1
      ITEM "320"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_5 TEXT 80 375 40 20
      NUMITEMS = 1
      ITEM "25"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_15 LABEL 106 351 233 18
      VALUE "Histogram and Adjustable Parameters"
      FRAME = 1
      ALIGNCENTER
      END
      WID_LABEL_14 LABEL 280 377 50 18
      VALUE "Num Bins"
      ALIGNLEFT
      END
      WID_LABEL_13 LABEL 133 377 70 18
      VALUE "Max Bin Size:"
      ALIGNLEFT
      END
      WID_LABEL_12 LABEL 13 377 66 18
      VALUE "Min Bin Size:"
      ALIGNLEFT
      END
      WID_TEXT_16 TEXT 106 725 76 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_19 LABEL 8 728 98 18
      VALUE "Average Blob Area:"
      ALIGNLEFT
      END
      WID_TEXT_15 TEXT 193 703 76 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_TEXT_14 TEXT 187 678 76 19
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_18 LABEL 8 680 179 18
      VALUE "Average distance between all blobs:"
      ALIGNLEFT
      END
      WID_LABEL_17 LABEL 8 705 189 18
      VALUE "Average distance to nearest neighbor:"
      ALIGNLEFT
      END
      WID_LABEL_16 LABEL 12 625 233 18
      VALUE "Analysis Results"
      FRAME = 1
      ALIGNCENTER
      END
      WID_LABEL_36 LABEL 6 656 41 18
      VALUE "Count:"
      ALIGNLEFT
      END
      WID_TEXT_27 TEXT 41 653 76 19
      WIDTH = 20
      HEIGHT = 1
      END
    END
    WID_BASE_4 BASE 0 0 1321 824
    XPAD = 3
    YPAD = 3
    SPACE = 3
    CAPTION "Multiple File Processing"
    BEGIN
      WID_LABEL_20 LABEL 8 9 215 18
      VALUE "Set parameters for analysis on previous tabs"
      FRAME = 1
      ALIGNLEFT
      END
      WID_DRAW_2 DRAW 539 21 724 250
      FRAME = 1
      END
      WID_DRAW_3 DRAW 528 294 738 250
      FRAME = 1
      END
      WID_DRAW_4 DRAW 535 567 732 250
      FRAME = 1
      END
      WID_LABEL_21 LABEL 10 44 56 16
      VALUE "Increment:"
      ALIGNLEFT
      END
      WID_TEXT_17 TEXT 68 41 35 18
      NUMITEMS = 1
      ITEM "1"
      EDITABLE
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_22 LABEL 539 0 73 18
      VALUE "Average Area"
      FRAME = 1
      ALIGNLEFT
      END
      WID_LABEL_23 LABEL 538 275 86 18
      VALUE "Avg. Separation"
      FRAME = 1
      ALIGNLEFT
      END
      WID_LABEL_24 LABEL 535 548 86 18
      VALUE "Avg Min Distance"
      FRAME = 1
      ALIGNLEFT
      END
      WID_BUTTON_12 PUSHBUTTON 10 138 128 38
      VALUE "Save Averages"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "SaveAverage"
      END
      WID_BUTTON_13 PUSHBUTTON 10 185 128 38
      VALUE "Save Histogram"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "SaveHistogram"
      END
      WID_BUTTON_16 PUSHBUTTON 11 80 128 38
      VALUE "Analyze"
      FRAME = 1
      ALIGNCENTER
      ONACTIVATE "RunFullAnalysis"
      END
      WID_DRAW_7 DRAW 6 243 501 132
      END
      WID_LABEL_37 LABEL 219 224 39 18
      VALUE "Count"
      FRAME = 1
      ALIGNCENTER
      END
      WID_LABEL_38 LABEL 238 92 57 18
      VALUE "Processing"
      ALIGNCENTER
      END
      WID_TEXT_9 TEXT 244 48 162 23
      WIDTH = 20
      HEIGHT = 1
      END
      WID_LABEL_39 LABEL 343 94 20 18
      VALUE "of"
      ALIGNCENTER
      END
      WID_TEXT_10 TEXT 364 90 46 23
      WIDTH = 20
      HEIGHT = 1
      END
    END
  END
END
