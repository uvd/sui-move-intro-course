## Sui Move Packages and Upgrade Basics
In Sui, a Move package is a collection of Move modules that becomes a unique object 
when published to the Sui blockchain. Package upgrades are implemented by modifying 
existing packages and publishing new versions.

## Key Concepts
- original ID: The immutable ID assigned when the package is first published
- Upgrade Policy: The upgrade rules specified when publishing the package
- Compatibility: Ensuring upgrades don't break existing contracts

### Detailed Explanation and Implementation of Package Upgrade Policies

Fundamental Concepts of Upgrade Policies control the rules for updating 
subsequent versions of already published packages and are a crucial component of Sui Move package management. Well-designed upgrade policies can ensure system stability while maintaining flexibility.

Sui supports four upgrade policies:

#### 1. Immutable
 The package can never be upgraded

#### 2. Dependency-only
You can modify the dependencies of the package only.

#### 3. Additive
Only new features can be added, existing functionality cannot be modified or removed

#### 4. Compatible
The most relaxed policy. In addition to what the more restrictive policies allow, in an upgraded version of the package:
- You can change all function implementations.
- You can remove the ability constraints on generic type parameters in function signatures.
- You can change, remove, or make public any private, public(friend), and entry function signatures.
- You cannot change public function signatures (except in the case of ability constraints mentioned previously).
- You cannot change existing types.
The `Compatible` policy allows:
- Adding new functions
- Adding new structs
- Adding new constants
- Modifying private function implementations
- Adding capabilities to structs
It prohibits:
- Removing or renaming existing functions
- Modifying public function signatures
- Removing or renaming structs
- Modifying struct fields


### How to change upgrade policies
When you publish a package, by default it adopts the most relaxed,
compatible policy. You can publish a package as part of a transaction that can change the policy before the transaction successfully completes, making the package available on chain for the first time at the desired policy level, 
rather than at the default one.

[sui framework](https://github.com/MystenLabs/sui/blob/main/crates/sui-framework/packages/sui-framework/sources/package.move#L252)
```move
/// Restrict upgrades through this upgrade `cap` to just add code, or
/// change dependencies.
public entry fun only_additive_upgrades(cap: &mut UpgradeCap) {
    cap.restrict(ADDITIVE)
}

/// Restrict upgrades through this upgrade `cap` to just change
/// dependencies.
public entry fun only_dep_upgrades(cap: &mut UpgradeCap) {
    cap.restrict(DEP_ONLY)
}


/// Discard the `UpgradeCap` to make a package immutable.
public entry fun make_immutable(cap: UpgradeCap) {
    let UpgradeCap { id, package: _, version: _, policy: _ } = cap;
    id.delete();
}
```

change to `Additive`
```shell
sui client call  \
--package 0x2 \
--module package \
--function only_additive_upgrades \
--args 0x...
```

change to `Dependency-only`
```shell
sui client call  \
--package 0x2 \
--module package \
--function only_dep_upgrades \
--args 0x...
```

change to `Immutable`
```shell
sui client call  \
--package 0x2 \
--module package \
--function make_immutable \
--args 0x...
```


The four upgrade policies can be changed in this sequence to adjust the policies.
`Compatible ->   Additive ->  Dependency-only -> Immutable`

- You can change `Compatible` to `Additive`  `ependency-only` `Immutable`
- You can change `Additive` to `Dependency-only`  `Immutable`
- You can change `Dependency-only` to `Immutable`

Change is irreversible.
- You can't change `Additive` to `Compatible` .
- You can't change `Immutable` to `Compatible` or  `Additive`  or `Dependency-only`  .
- You can't change `Dependency-only` to `Compatible` or  `Additive` 
