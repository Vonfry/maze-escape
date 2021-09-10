{-# LANGUAGE MultiParamTypeClasses #-}

module Game.Maze where

class MovableCell cell where
  movable :: cell -> Bool

class Maze2D map pos cell where
  adjacence :: map pos cell -> pos -> [pos]

  source :: map pos cell -> [pos]

  destination :: map pos cell -> [pos]

  getCell :: map pos cell -> pos -> cell

  shortestEscapePath :: map pos cell -> [pos]
  shortestEscapePath = source
