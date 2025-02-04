-- Семена тыквы сохраняют всхожесть 8 лет, а пшеницы – на 8 лет больше. Сколько лет пшеница сохраняет всхожесть?
-- https://giga.chat/link/gcsmRvvCrx

-- Функция для определения срока хранения всхожести семян пшеницы
wheatGerminationYears :: Int -> Int
wheatGerminationYears pumpkinYears = pumpkinYears + 8

main :: IO ()
main = do
  let pumpkinYears = 8   -- Срок хранения семян тыквы
      wheatYears = wheatGerminationYears pumpkinYears
  
  putStrLn $ "Пшеница сохраняет всхожесть " ++ show wheatYears ++ " лет."
