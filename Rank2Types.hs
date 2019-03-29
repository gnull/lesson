{-# LANGUAGE RankNTypes #-}

type Request = String
type Response = String

type App = forall a. Request -> (Response -> IO a) -> IO a

-- Хорошее приложение коммпилируется

app :: App
app r resp = do
  writeFile "/tmp/log" "Запись в лог"
  resp $ "Мой ответ на " ++ show r

-- А плохое — не коммпилируется

-- Не понятно, что здесь писать, значение типа a не сконструировать без
-- вызова к resp

-- app' :: App
-- app' r resp = return $ ??
