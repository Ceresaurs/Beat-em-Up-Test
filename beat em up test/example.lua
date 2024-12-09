local myTable = { x = 0 }
function myTable:myFunction ( ) 

  self.x = 1- self is inferred from the colon syntax

end
myTable:myFunction ( )

-- is functionally equivalent to

local myTable = { x = 0 }
function myTable.myFunction ( tab )  -- "tab" could be named "self" or whatever you want
   
  tab.x = 1

end
myTable.myFunction ( myTable )  
