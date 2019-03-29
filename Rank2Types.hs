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

-- На самом деле App можно определить и без RankNTypes:

type App' a = Request -> (Response -> IO a) -> IO a

-- Но тогда forall придётся накинуть в определении функции, которая будет
-- принимать приложение. Вот так:

runApp' :: (forall a. App' a) -> IO ()
runApp' f = undefined

-- В то время как для предыдущего определения, которое само содержит forall,
-- можно обойтись без этого:

runApp :: App -> IO ()
runApp f = undefined
