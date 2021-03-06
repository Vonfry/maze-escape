{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE ViewPatterns #-}

module Game.Maze (MovableCell(..), Maze2D(..)) where

import Data.Function (on)
import Data.Foldable (minimumBy)
import Data.Ord (comparing)
import Data.Map (Map(..), empty, insert, (!?))
import Control.Monad.State
import Control.Monad.Reader

class MovableCell cell where
  movable :: cell -> Bool

class (MovableCell cell, Ord pos) => Maze2D map pos cell where
  adjacence :: map pos cell -> pos -> [pos]

  source :: map pos cell -> [pos]

  destination :: map pos cell -> [pos]

  getCell :: map pos cell -> pos -> cell

  shortestEscapePath :: map pos cell -> [pos]
  shortestEscapePath = flip evalState empty . runDfs
    where
      runDfs = runReaderT =<< dfs . source

data MapEscapeMark pos =
  MapEscapeMark { marked :: Bool
                , toDest :: [pos]
                }
type RMapEscapeState pos = State (Map pos (MapEscapeMark pos))
type RMapEscape map pos = ReaderT map (RMapEscapeState pos) [pos]

filterMinLength :: [[pos]] -> [pos]
filterMinLength poss =
  case filterOutNull poss of [] -> []
                             poss -> filterByMin poss
    where
      filterByMin = minimumBy $ comparing length

filterOutNull = filter $ not . null


dfs :: Maze2D map pos cell => [pos] -> RMapEscape (map pos cell) pos
dfs = fmap filterMinLength . traverse dfs'

dfs' :: Maze2D map pos cell => pos -> RMapEscape (map pos cell) pos
dfs' p = do
  maze <- ask
  let curCell = getCell maze p
      sources = source maze
      dests = destination maze
      markedMap = MapEscapeMark { marked = True, toDest = [] }
      adjNodes = adjacence maze p
      movableNodes = filter (movable . getCell maze) adjNodes
      nextNodes = movableNodes
  escapeState <- get
  case escapeState !? p of
    Nothing -> do
      modify $ insert p markedMap
      toDest <-
        if p `elem` dests
        then pure [p]
        else do
          minAfterPath <- dfs nextNodes
          case minAfterPath of
            [] -> pure []
            _  -> pure $ p : minAfterPath
      modify $ insert p $ markedMap { toDest = toDest }
      pure toDest
    Just MapEscapeMark {..} -> pure toDest
      -- key existing implies isMarked, because it is inserted only after being
      -- marked.

