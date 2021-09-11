{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiWayIf #-}

module Game.Maze.Data
  ( MazeCell(..)
  , MazeMapList(..)
  , MazeMapListPos
  )
where

import Game.Maze
import Data.List.Index (ifoldr)
import Control.Monad (unless)
import Data.Monoid.HT (when)

data MazeCell = S -- ^ source
              | D -- ^ destination
              | X -- ^ blocked
              | O -- ^ road
              deriving Eq

newtype MazeMapList pos cell = MazeMapList [[cell]]

type MazeMapListPos = (Int, Int)

instance MovableCell MazeCell where
  movable X = False
  movable _ = True

instance Maze2D MazeMapList MazeMapListPos MazeCell where
  adjacence (MazeMapList cells) (x, y) =
    withUp <> withDown <> withLeft <> withRight
      where
        withUp = when (y > 0) $ pure up
        withDown = when (y < lcol - 1) $ pure down
        withLeft = when (x > 0) $ pure left
        withRight = when (x < lrow - 1) $ pure right
        row = cells !! x
        lrow = length row
        lcol = length cells
        up    = (x, y - 1)
        down  = (x, y + 1)
        left  = (x - 1, y)
        right = (x + 1, y)

  getCell (MazeMapList cells) (x,y) = cells !! x !! y

  source = flip findCellEq S

  destination = flip findCellEq D

type MazeMap = MazeMapList MazeMapListPos MazeCell

findCellEq :: MazeMap -> MazeCell -> [MazeMapListPos]
findCellEq (MazeMapList cells) c = ifoldr (flip . ifoldr . f') [] cells
  where
    f' i j cell poss = if cell == c then (i, j) : poss else poss


