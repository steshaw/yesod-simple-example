module Settings.TH where

import Control.Applicative
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
-- From https://stackoverflow.com/a/16163949/482382
--
addDependentFileRelative :: FilePath -> Q [Dec]
addDependentFileRelative relativeFile = do
    currentFilename <- loc_filename <$> location
    pwd             <- runIO getCurrentDirectory

    let invocationRelativePath = takeDirectory (pwd </> currentFilename) </> relativeFile

    addDependentFile invocationRelativePath

    returnQ []
