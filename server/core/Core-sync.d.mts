type Nullable<T> = T | null | undefined
declare function KtSingleton<T>(): T & (abstract new() => any);
export declare function syncProblem(opJson: string): Nullable<string>;
export declare function syncMerge(currentJson: Nullable<string>, opJson: string): string;