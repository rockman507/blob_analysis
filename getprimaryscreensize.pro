FUNCTION GetPrimaryScreenSize, Exclude_Taskbar=exclude_Taskbar
      oMonInfo = Obj_New('IDLsysMonitorInfo')
      rects = oMonInfo -> GetRectangles(Exclude_Taskbar=exclude_Taskbar)
      pmi = oMonInfo -> GetPrimaryMonitorIndex()
      Obj_Destroy, oMonInfo
      Return, rects[[2, 3], pmi]
   END