-----------------------------------------------------------------------------
-- |
-- Module      :  Heidi
-- Description :  tidy data in Haskell
-- Copyright   :  (c) Marco Zocca (2018-2020)
-- License     :  BSD-style
-- Maintainer  :  ocramz fripost org
-- Stability   :  experimental
-- Portability :  GHC
--
-- Heidi : tidy data in Haskell
--
-- The purpose of this library is to make it easy to analyze collections of Haskell values; users 'encode' their data collections (lists, maps and so on) into dataframes, and use functions provided by `heidi` for manipulation.
--
--
-----------------------------------------------------------------------------
{-# options_ghc -Wno-unused-imports #-}
module Heidi (
  -- * Frame
  Frame
  -- ** Construction
  -- *** Encoding
  , encode, Heidi(toVal), Val, TC, VP(..)
  -- *** Direct
  , frameFromList
  -- ** Access
  , head, take, drop, numRows
  -- ** Filtering
  , filter, filterA
  -- ** Grouping
  , groupWith
  -- ** Zipping
  , zipWith
  -- ** Scans
  , scanl, scanr
  -- * Data tidying
  , spreadWith, gatherWith
  -- * Relational operations
  , groupBy, innerJoin, leftOuterJoin
  -- * Vector-related
  , toVector, fromVector

  -- * Row
  , Row
  -- ** Construction
  , rowFromList
  -- ** Access
  , toList, keys
  -- ** Filtering
  , delete, filterWithKey, filterWithKeyPrefix, filterWithKeyAny
  , deleteMany
  -- ** Partitioning
  , partitionWithKey, partitionWithKeyPrefix
  -- -- ** Decoders
  -- , real, scientific, text, string, oneHot
  -- ** Lookup
  , lookup
  -- , lookupThrowM
  , (!:), elemSatisfies
  -- ** Lookup utilities
  , maybeEmpty
  -- ** Comparison by lookup
  , eqByLookup, eqByLookups
  , compareByLookup
  -- ** Set operations
  , union, unionWith
  , intersection, intersectionWith
  -- ** Maps
  , mapWithKey
  -- ** Folds
  , foldWithKey, keysOnly
  -- ** Traversals
  , traverseWithKey
  -- ** Lens combinators
  -- *** Traversals
  , int, bool, float, double, char, string, text, scientific, oneHot
  -- *** Getters
  , real, txt
  -- , flag
  -- *** Combinators
  , at, keep
  -- **** Combinators for list-indexed rows
  , atPrefix, eachPrefixed, foldPrefixed
  -- ** Encode internals
  , tcTyN, tcTyCon, mkTyN, mkTyCon
  , flattenHM, flattenGT, flatten
  -- , DataException(..)
  , OneHot, onehotIx
  )
  where

import Control.Monad.Catch (MonadThrow(..))

import Core.Data.Frame.List (Frame, frameFromList, head, take, drop, zipWith, numRows, filter, filterA, groupWith, scanl, scanr, toVector, fromVector)
import Core.Data.Frame.Generic (encode)
import Data.Generics.Encode.Internal (Heidi(..), VP(..), getIntM, getInt8M, getInt16M, getInt32M, getInt64M, getWordM, getWord8M, getWord16M, getWord32M, getWord64M, getBoolM, getFloatM, getDoubleM, getScientificM, getCharM, getStringM, getTextM, getOneHotM, TypeError(..), TC(..), tcTyN, tcTyCon, mkTyN, mkTyCon, flattenHM, flattenGT, flatten, Val)
import Data.Generics.Encode.OneHot (OneHot, onehotIx)
import Heidi.Data.Row.GenericTrie
import Heidi.Data.Frame.Algorithms.GenericTrie (innerJoin, leftOuterJoin, gatherWith, spreadWith, groupBy)

-- import Control.Monad.Catch (MonadThrow(..))
import Prelude hiding (filter, zipWith, lookup, foldl, foldr, scanl, scanr, head, take, drop)
