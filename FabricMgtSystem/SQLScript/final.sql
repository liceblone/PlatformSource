
ALTER TABLE TPdtWhinDL  ADD FMainQty AS (isnull((isnull([F46Y],0) + isnull([F46A],0) + isnull([F46B],0) + isnull([F46C],0) + isnull([F48A],0) + isnull([F48B],0) + isnull([F48C],0) + isnull([F50A],0) + isnull([F50B],0) + isnull([F50C],0) + isnull([F52A],0) + isnull([F52B],0) + isnull([F52C],0) + isnull([F54A],0) + isnull([F54B],0) + isnull([F54C],0) + isnull([F99A],0) + isnull([F99B],0)),0))
ALTER TABLE TPdtWhinDL  ADD FOrdQty AS (isnull((isnull([F46Y],0) + isnull([F46A],0) + isnull([F46B],0) + isnull([F46C],0) + isnull([F48A],0) + isnull([F48B],0) + isnull([F48C],0) + isnull([F50A],0) + isnull([F50B],0) + isnull([F50C],0) + isnull([F52A],0) + isnull([F52B],0) + isnull([F52C],0) + isnull([F54A],0) + isnull([F54B],0) + isnull([F54C],0) + isnull([F99A],0) + isnull([F99B],0)),0))

 ALTER TABLE TPdtWhOutDL  ADD FOutQty AS (isnull((isnull([F46Y],0) + isnull([F46A],0) + isnull([F46B],0) + isnull([F46C],0) + isnull([F48A],0) + isnull([F48B],0) + isnull([F48C],0) + isnull([F50A],0) + isnull([F50B],0) + isnull([F50C],0) + isnull([F52A],0) + isnull([F52B],0) + isnull([F52C],0) + isnull([F54A],0) + isnull([F54B],0) + isnull([F54C],0) + isnull([F99A],0) + isnull([F99B],0)),0))

 