{-# LANGUAGE MultiParamTypeClasses #-}

module Game.Maze (MovableCell(..), Maze2D(..)) where

import Data.Function (on)
import Data.Foldable (minimumBy)
import Data.Ord (comparing)
import Data.Map (Map(..), empty)
import Control.Monad.State
import Control.Monad.Reader

class MovableCell cell where
  movable :: cell -> Bool

class Eq pos => Maze2D map pos cell where
  adjacence :: map pos cell -> pos -> [pos]

  source :: map pos cell -> [pos]

  destination :: map pos cell -> [pos]

  getCell :: map pos cell -> pos -> cell

  shortestEscapePath :: map pos cell -> [pos]
  shortestEscapePath = flip evalState empty . runBfs
    where
      runBfs = runReaderT =<< bfs . source
      bfs :: [pos] -> RMapEscape map pos
      bfs _ = pure []

data MapEscapeMark pos =
  MapEscapeMark { marked :: Bool
                , toDest :: [pos]
                }
type RMapEscapeState pos = State (Map pos (MapEscapeMark pos))
type RMapEscape map pos = ReaderT map (RMapEscapeState pos) [pos]

filterMinLength :: [[pos]] -> [pos]
filterMinLength = minimumBy $ comparing length
