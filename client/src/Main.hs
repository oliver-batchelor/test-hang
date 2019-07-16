module Client where

import Control.Monad (forM_)
import Data.Monoid ((<>))
import Control.Monad.IO.Class (MonadIO(..))
import Control.Concurrent (forkIO)
import Control.Concurrent.MVar (takeMVar, putMVar, newEmptyMVar)
import Control.Lens ((^.))
import Language.Javascript.JSaddle
       (jsg, jsg3, js, js1, jss, fun, valToNumber, syncPoint,
        nextAnimationFrame, runJSM, askJSM, global)
import Language.Javascript.JSaddle.Warp (debug)
import Language.Javascript.JSaddle.Run (enableLogging)

main = debug 3708 $ do
    enableLogging True
    doc <- jsg "document"
    doc ^. js "body" ^. jss "innerHTML" ("<h1>Kia ora (Hi)</h1>")

    -- Create a haskell function call back for the onclick event
    doc ^. jss "onmousemove" (fun $ \ _ _ [e] -> do
        x <- e ^. js "clientX" >>= valToNumber
        y <- e ^. js "clientY" >>= valToNumber

        forM_ [1..1000] $ \_ ->
            doc ^. js "body" ^. jss "innerHTML" ("<h1>Kia ora (Hi)" <> show (x, y) <> "</h1>")

        liftIO $ print (x, y)
        return ())