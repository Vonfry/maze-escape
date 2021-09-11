{-# LANGUAGE MultiParamTypeClasses #-}

module Game.Maze (MovableCell(..), Maze2D(..)) where

import Data.Function (on)
import Data.Foldable (minimumBy)
import Data.Ord (comparing)

class MovableCell cell where
  movable :: cell -> Bool

class Maze2D map pos cell where
  adjacence :: map pos cell -> pos -> [pos]

  source :: map pos cell -> [pos]

  destination :: map pos cell -> [pos]

  getCell :: map pos cell -> pos -> cell

  shortestEscapePath :: map pos cell -> [pos]
  shortestEscapePath = filterMinLength . fmap bfs . source
    where
      filterMinLength = minimumBy $ comparing length
      -- TODO
      bfs _ = []
