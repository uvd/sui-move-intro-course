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