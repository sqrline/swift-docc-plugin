// This source file is part of the Swift.org open source project
//
// Copyright (c) 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for Swift project authors

import PackagePlugin

extension SwiftSourceModuleTarget {
    /// Returns the default options that should be used for generating a symbol graph for the
    /// current target in the given package.
    func defaultSymbolGraphOptions(in package: Package) -> PackageManager.SymbolGraphOptions {
        let targetMinimumAccessLevel: PackageManager.SymbolGraphOptions.AccessLevel = .public
        
#if swift(>=5.9)
        let emitExtensionBlockSymbolDefault = true
#else
        let emitExtensionBlockSymbolDefault = false
#endif
        
        return PackageManager.SymbolGraphOptions(
            minimumAccessLevel: targetMinimumAccessLevel,
            includeSynthesized: true,
            includeSPI: false,
            emitExtensionBlocks: emitExtensionBlockSymbolDefault
        )
    }
}


#if swift(<5.8)
private extension PackageManager.SymbolGraphOptions {
    /// A compatibility layer for lower Swift versions which discards unknown parameters.
    init(minimumAccessLevel: PackagePlugin.PackageManager.SymbolGraphOptions.AccessLevel = .public,
         includeSynthesized: Bool = false,
         includeSPI: Bool = false,
         emitExtensionBlocks: Bool) {
        self.init(minimumAccessLevel: minimumAccessLevel, includeSynthesized: includeSynthesized, includeSPI: includeSPI)
    }
}
#endif
