import type { Account } from "./account";
import type { Jurisdiction } from "./directory";

/** The Durable Object of one account, in the jurisdiction its data lives in. */
export function accountStub(env: Env, account: { accountId: string; jurisdiction: Jurisdiction }): DurableObjectStub<Account> {
  const namespace = account.jurisdiction === "eu" ? env.ACCOUNT.jurisdiction("eu") : env.ACCOUNT;
  return namespace.get(namespace.idFromName(account.accountId)) as DurableObjectStub<Account>;
}
