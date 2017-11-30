--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: No licence
--

RegisterServerEvent("ft_base:debug")
AddEventHandler('ft_base:debug', function(value)

  print("---------[Debug]---------")
  TablePrint(value)
  print("-------------------------")

end)
