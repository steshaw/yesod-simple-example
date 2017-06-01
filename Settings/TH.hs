module Settings.TH where

import Prelude
import Language.Haskell.TH.Syntax
import System.Directory
import System.FilePath

-- |
--
-- Uses 'addDependentFile' on a file relative to the current file to mark it as
-- being checked for changes when compiled with TemplateHaskell.
--
-- Returns an empty list of declarations so that it can be used with:
--
-- >$(addDependentFileRelative "MyDependency.txt")
--
-- Adapted from <https://stackoverflow.com/a/16163949/482382>.
--
addDependentFileRelative :: FilePath -> Q [Dec]
addDependentFileRelative relativeFile = do
  currentFileName <- loc_filename <$> location
  currentFileAbsolute <- runIO $ makeAbsolute currentFileName
  let path = takeDirectory currentFileAbsolute </> relativeFile
  canonicalPath <- runIO $ canonicalizePath path
  addDependentFile canonicalPath
  returnQ []
