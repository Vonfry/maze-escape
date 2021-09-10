{-# LANGUAGE MultiParamTypeClasses #-}

module Game.Maze.Data where

import Game.Maze

data MazeCell = S -- ^ source
              | D -- ^ destination
              | X -- ^ blocked
              | O -- ^ road
              deriving Eq

newtype MazeMapList pos cell = MazeMapList [[cell]]

newtype MazeMapListPos = MazeMapListPos (Int, Int)

instance MovableCell MazeCell where
  movable X = False
  movable _ = True

instance Maze2D MazeMapList MazeMapListPos MazeCell where
  adjacence map pos = [] -- TODO

  getCell (MazeMapList cells) (MazeMapListPos (x,y)) = cells !! x !! y

  source = flip findCellEq S

  destination = flip findCellEq D

type MazeMap = MazeMapList MazeMapListPos MazeCell

findCellEq :: MazeMap -> MazeCell -> [MazeMapListPos]
findCellEq (MazeMapList cells) c = [] -- TODO
