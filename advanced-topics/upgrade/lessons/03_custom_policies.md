### Implementing Custom Upgrade Policies
For more complex upgrade control, 
you can implement custom policy functions:


### Upgrade overview
Package upgrades must occur end-to-end in a single transaction and are composed of three commands:

1. Authorization: Get permission from the UpgradeCap to perform the upgrade, creating an UpgradeTicket.
2. Execution: Consume the UpgradeTicket and verify the package bytecode and compatibility against the previous version, and create the on-chain object representing the upgraded package. Return an UpgradeReceipt as a result on success.
3.  Commit: Update the UpgradeCap with information about the newly created package.
While step 2 is a built-in command, steps 1 and 3 are implemented as Move functions. The Sui framework provides their most basic implementation:


Create Policy Module
```move
module custom::custom;
use sui::package;

const ENotAdmin: u64 = 1;
public struct UpgradeCap has key, store {
    id: UID,
    cap: package::UpgradeCap,
    admin: address,
}

public fun new_policy(
    cap: package::UpgradeCap,
    admin: address,
    ctx: &mut TxContext,
): UpgradeCap {
    UpgradeCap { id: object::new(ctx), cap, admin }
}


public fun authorize_upgrade(
    cap: &mut UpgradeCap,
    policy: u8,
    digest: vector<u8>,
    ctx: &TxContext,
): package::UpgradeTicket {
    assert!(cap.admin == ctx.sender(), ENotAdmin);
    cap.cap.authorize_upgrade(policy, digest)
}

public fun commit_upgrade(
    cap: &mut UpgradeCap,
    receipt: package::UpgradeReceipt,
) {
    cap.cap.commit_upgrade(receipt)
}

public fun make_immutable(cap: UpgradeCap) {
    let UpgradeCap { id, cap, admin : _ } = cap;
    id.delete();
    cap.make_immutable()
}
```

The contract stipulates that only the designated administrator address can upgrade.


### Best Practices for Upgrade Policies
- Production recommendation: Use "compatible" as base policy
- Critical contracts: Add additional protection with custom policies
- Test policies: Thoroughly test upgrade process on testnet
- Documentation: Clearly record package upgrade policies and change requirements
- Gradual upgrades: Consider using new packages rather than forced upgrades for major changes


### Practical Upgrade Operation Example
After configuring upgrade policies, use Sui CLI to upgrade package:

```shell
sui client upgrade --upgrade-capability 0xCAP_ID
```

Where `upgrade-capability` must meet the requirements defined in the package's upgrade policy.

By properly setting upgrade policies, 
you can ensure the stability and security of critical contracts while maintaining
system maintainability. Choosing the appropriate policy level based on project needs is an important decision in Sui Move development.