{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}

module Game.Maze.Data where

import Game.Maze
import Data.List.Index (ifoldr)

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
  -- | assume the map is a matrix istead of atactic one.
  adjacence map pos = [] -- TODO

  getCell (MazeMapList cells) (x,y) = cells !! x !! y

  source = flip findCellEq S

  destination = flip findCellEq D

type MazeMap = MazeMapList MazeMapListPos MazeCell

findCellEq :: MazeMap -> MazeCell -> [MazeMapListPos]
findCellEq (MazeMapList cells) c = ifoldr (flip . ifoldr . f') [] cells
  where
    f' i j cell poss = if cell == c then (i, j) : poss else poss


