import {
  Long2qws0ah9gnpki as Long,
  Regex_init_$Create$2nx0fagcwc0mz as Regex_init_$Create$,
  protoOf180f3jzyo7rfj as protoOf,
  initMetadataForCompanion1wyw17z38v6ac as initMetadataForCompanion,
  toString1pkumu07cwy4m as toString,
  getStringHashCode26igk1bx568vk as getStringHashCode,
  hashCodeq5arwsb9dgti as hashCode,
  equals2au1ep9vhcato as equals,
  initMetadataForClassbxx6q50dy2s7 as initMetadataForClass,
  Unit_instance3kz1zqli6gr1r as Unit_instance,
  VOID3gxj6tk5isa35 as VOID,
  Collection1k04j3hzsbod0 as Collection,
  isInterface3d6p8outrmvmk as isInterface,
  encodeToByteArray1onwao0uakjfh as encodeToByteArray,
  toMutableMapr5f3w62lv8sk as toMutableMap,
  LinkedHashMap_init_$Create$s27yccuovnls as LinkedHashMap_init_$Create$,
  compareTo3ankvs086tmwq as compareTo,
  Companion_instancejy2056q2ma5w as Companion_instance,
  _Result___init__impl__xyqfz832zdzqrocazzs as _Result___init__impl__xyqfz8,
  createFailure8paxfkfa5dc7 as createFailure,
  _Result___get_value__impl__bjfvqg9vwgdwmhxc4m as _Result___get_value__impl__bjfvqg,
  _Result___get_isFailure__impl__jpiriv2yxkms7bg2hpm as _Result___get_isFailure__impl__jpiriv,
  getValue48kllevslyh6 as getValue,
  to2cs3ny02qtbcb as to,
  mapCapacity1h45rc3eh9p2l as mapCapacity,
  LinkedHashMap_init_$Create$21wpz6bm2n4yn as LinkedHashMap_init_$Create$_0,
  mapOf1xd03cq9cnmy8 as mapOf,
  initMetadataForObject1cxne3s9w65el as initMetadataForObject,
  IllegalArgumentException_init_$Create$1gox8sdqs91jy as IllegalArgumentException_init_$Create$,
} from './kotlin-kotlin-stdlib.mjs';
import {
  Jsonsmkyu9xjl7fv as Json,
  JsonPrimitive3ttzjh2ft5dnx as JsonPrimitive,
  JsonObjectee06ihoeeiqj as JsonObject,
  JsonNull2liwjj96vm0w2 as JsonNull,
  get_jsonObject2u4z2ch1uuca9 as get_jsonObject,
  get_jsonPrimitivez17tyd5rw1ql as get_jsonPrimitive,
  get_intOrNulld29i64b3udf as get_intOrNull,
  JsonPrimitiveolttw629wj53 as JsonPrimitive_0,
} from './kotlinx-serialization-kotlinx-serialization-json.mjs';
//region block: imports
var imul = Math.imul;
//endregion
//region block: pre-declaration
initMetadataForCompanion(Companion);
initMetadataForClass(Op, 'Op');
initMetadataForClass(SyncRecord, 'SyncRecord');
initMetadataForObject(SyncRules, 'SyncRules');
//endregion
function Companion() {
  Companion_instance_0 = this;
  this.MAX_MILLIS_1 = new Long(-1486618625, 232830643);
  this.MAX_COUNTER_1 = 99999;
  this.NODE_1 = Regex_init_$Create$('[0-9a-zA-Z_-]{1,64}');
  this.ENCODED_1 = Regex_init_$Create$('(\\d{18})-(\\d{5})-([0-9a-zA-Z_-]{1,64})');
}
protoOf(Companion).isValid_lc9qh4_k$ = function (text) {
  return this.ENCODED_1.matches_evli6i_k$(text);
};
var Companion_instance_0;
function Companion_getInstance() {
  if (Companion_instance_0 == null)
    new Companion();
  return Companion_instance_0;
}
function Op(id, table, row, fields, hlc, schema) {
  this.id_1 = id;
  this.table_1 = table;
  this.row_1 = row;
  this.fields_1 = fields;
  this.hlc_1 = hlc;
  this.schema_1 = schema;
}
protoOf(Op).toString = function () {
  return 'Op(id=' + this.id_1 + ', table=' + this.table_1 + ', row=' + this.row_1 + ', fields=' + toString(this.fields_1) + ', hlc=' + this.hlc_1 + ', schema=' + this.schema_1 + ')';
};
protoOf(Op).hashCode = function () {
  var result = getStringHashCode(this.id_1);
  result = imul(result, 31) + getStringHashCode(this.table_1) | 0;
  result = imul(result, 31) + getStringHashCode(this.row_1) | 0;
  result = imul(result, 31) + hashCode(this.fields_1) | 0;
  result = imul(result, 31) + getStringHashCode(this.hlc_1) | 0;
  result = imul(result, 31) + this.schema_1 | 0;
  return result;
};
protoOf(Op).equals = function (other) {
  if (this === other)
    return true;
  if (!(other instanceof Op))
    return false;
  if (!(this.id_1 === other.id_1))
    return false;
  if (!(this.table_1 === other.table_1))
    return false;
  if (!(this.row_1 === other.row_1))
    return false;
  if (!equals(this.fields_1, other.fields_1))
    return false;
  if (!(this.hlc_1 === other.hlc_1))
    return false;
  if (!(this.schema_1 === other.schema_1))
    return false;
  return true;
};
function SyncRecord(fields, clocks) {
  this.fields_1 = fields;
  this.clocks_1 = clocks;
}
protoOf(SyncRecord).toString = function () {
  return 'SyncRecord(fields=' + toString(this.fields_1) + ', clocks=' + toString(this.clocks_1) + ')';
};
protoOf(SyncRecord).hashCode = function () {
  var result = hashCode(this.fields_1);
  result = imul(result, 31) + hashCode(this.clocks_1) | 0;
  return result;
};
protoOf(SyncRecord).equals = function (other) {
  if (this === other)
    return true;
  if (!(other instanceof SyncRecord))
    return false;
  if (!equals(this.fields_1, other.fields_1))
    return false;
  if (!equals(this.clocks_1, other.clocks_1))
    return false;
  return true;
};
function SyncRules$json$lambda($this$Json) {
  $this$Json.encodeDefaults_1 = true;
  return Unit_instance;
}
function SyncRules() {
  SyncRules_instance = this;
  this.DELETED_AT_1 = 'deleted_at';
  this.MAX_FIELDS_1 = 64;
  this.MAX_FIELDS_BYTES_1 = 32768;
  this.TABLE_1 = Regex_init_$Create$('[a-z][a-z0-9_]{0,31}');
  this.FIELD_1 = Regex_init_$Create$('[a-z][a-z0-9_]{0,63}');
  this.ID_1 = Regex_init_$Create$('[0-9A-Za-z_.:|-]{1,128}');
  var tmp = this;
  tmp.json_1 = Json(VOID, SyncRules$json$lambda);
}
protoOf(SyncRules).problem_1u3chc_k$ = function (op) {
  var tmp;
  if (!this.ID_1.matches_evli6i_k$(op.id_1)) {
    tmp = 'invalid op id';
  } else {
    if (!this.TABLE_1.matches_evli6i_k$(op.table_1)) {
      tmp = 'invalid table';
    } else {
      if (!this.ID_1.matches_evli6i_k$(op.row_1)) {
        tmp = 'invalid row id';
      } else {
        if (!Companion_getInstance().isValid_lc9qh4_k$(op.hlc_1)) {
          tmp = 'invalid hlc';
        } else {
          if (op.schema_1 < 0) {
            tmp = 'invalid schema';
          } else {
            if (op.fields_1.isEmpty_y1axqb_k$()) {
              tmp = 'no fields';
            } else {
              if (op.fields_1.get_size_woubt6_k$() > 64) {
                tmp = 'too many fields';
              } else {
                var tmp0 = op.fields_1.get_keys_wop4xp_k$();
                var tmp$ret$0;
                $l$block_0: {
                  // Inline function 'kotlin.collections.any' call
                  var tmp_0;
                  if (isInterface(tmp0, Collection)) {
                    tmp_0 = tmp0.isEmpty_y1axqb_k$();
                  } else {
                    tmp_0 = false;
                  }
                  if (tmp_0) {
                    tmp$ret$0 = false;
                    break $l$block_0;
                  }
                  var _iterator__ex2g4s = tmp0.iterator_jk1svi_k$();
                  while (_iterator__ex2g4s.hasNext_bitz1p_k$()) {
                    var element = _iterator__ex2g4s.next_20eer_k$();
                    if (!SyncRules_getInstance().FIELD_1.matches_evli6i_k$(element) || element === 'id') {
                      tmp$ret$0 = true;
                      break $l$block_0;
                    }
                  }
                  tmp$ret$0 = false;
                }
                if (tmp$ret$0) {
                  tmp = 'invalid field name';
                } else {
                  var tmp0_0 = op.fields_1.get_values_ksazhn_k$();
                  var tmp$ret$2;
                  $l$block_2: {
                    // Inline function 'kotlin.collections.any' call
                    var tmp_1;
                    if (isInterface(tmp0_0, Collection)) {
                      tmp_1 = tmp0_0.isEmpty_y1axqb_k$();
                    } else {
                      tmp_1 = false;
                    }
                    if (tmp_1) {
                      tmp$ret$2 = false;
                      break $l$block_2;
                    }
                    var _iterator__ex2g4s_0 = tmp0_0.iterator_jk1svi_k$();
                    while (_iterator__ex2g4s_0.hasNext_bitz1p_k$()) {
                      var element_0 = _iterator__ex2g4s_0.next_20eer_k$();
                      if (!(element_0 instanceof JsonPrimitive)) {
                        tmp$ret$2 = true;
                        break $l$block_2;
                      }
                    }
                    tmp$ret$2 = false;
                  }
                  if (tmp$ret$2) {
                    tmp = 'fields must be plain values';
                  } else {
                    if (encodeToByteArray((new JsonObject(op.fields_1)).toString()).length > 32768) {
                      tmp = 'fields too large';
                    } else {
                      tmp = null;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return tmp;
};
protoOf(SyncRules).merge_mh7e5i_k$ = function (current, op) {
  var tmp1_safe_receiver = current == null ? null : current.fields_1;
  var tmp2_elvis_lhs = tmp1_safe_receiver == null ? null : toMutableMap(tmp1_safe_receiver);
  var tmp;
  if (tmp2_elvis_lhs == null) {
    // Inline function 'kotlin.collections.mutableMapOf' call
    tmp = LinkedHashMap_init_$Create$();
  } else {
    tmp = tmp2_elvis_lhs;
  }
  var fields = tmp;
  var tmp4_safe_receiver = current == null ? null : current.clocks_1;
  var tmp5_elvis_lhs = tmp4_safe_receiver == null ? null : toMutableMap(tmp4_safe_receiver);
  var tmp_0;
  if (tmp5_elvis_lhs == null) {
    // Inline function 'kotlin.collections.mutableMapOf' call
    tmp_0 = LinkedHashMap_init_$Create$();
  } else {
    tmp_0 = tmp5_elvis_lhs;
  }
  var clocks = tmp_0;
  // Inline function 'kotlin.collections.iterator' call
  var _iterator__ex2g4s = op.fields_1.get_entries_p20ztl_k$().iterator_jk1svi_k$();
  while (_iterator__ex2g4s.hasNext_bitz1p_k$()) {
    var _destruct__k2r9zo = _iterator__ex2g4s.next_20eer_k$();
    // Inline function 'kotlin.collections.component1' call
    var name = _destruct__k2r9zo.get_key_18j28a_k$();
    // Inline function 'kotlin.collections.component2' call
    var value = _destruct__k2r9zo.get_value_j01efc_k$();
    var clock = clocks.get_wei43m_k$(name);
    var later = clock == null || compareTo(op.hlc_1, clock) > 0;
    var tmp_1;
    if (name === 'deleted_at') {
      // Inline function 'kotlin.let' call
      var it = fields.get_wei43m_k$(name);
      var tmp_2;
      if (!(it == null)) {
        tmp_2 = !(it instanceof JsonNull);
      } else {
        tmp_2 = false;
      }
      var deleted = tmp_2;
      var tmp_3;
      if (value instanceof JsonNull) {
        tmp_3 = (!deleted && later);
      } else {
        if (!deleted) {
          tmp_3 = true;
        } else {
          tmp_3 = later;
        }
      }
      tmp_1 = tmp_3;
    } else {
      tmp_1 = later;
    }
    var wins = tmp_1;
    if (wins) {
      // Inline function 'kotlin.collections.set' call
      fields.put_4fpzoq_k$(name, value);
      // Inline function 'kotlin.collections.set' call
      var value_0 = op.hlc_1;
      clocks.put_4fpzoq_k$(name, value_0);
    }
  }
  return new SyncRecord(fields, clocks);
};
protoOf(SyncRules).decodeOp_kizvsb_k$ = function (text) {
  // Inline function 'kotlin.runCatching' call
  var tmp;
  try {
    // Inline function 'kotlin.Companion.success' call
    var value = this.opFrom_7gr1f6_k$(get_jsonObject(this.json_1.parseToJsonElement_rqvr2k_k$(text)));
    tmp = _Result___init__impl__xyqfz8(value);
  } catch ($p) {
    var tmp_0;
    if ($p instanceof Error) {
      var e = $p;
      // Inline function 'kotlin.Companion.failure' call
      tmp_0 = _Result___init__impl__xyqfz8(createFailure(e));
    } else {
      throw $p;
    }
    tmp = tmp_0;
  }
  // Inline function 'kotlin.Result.getOrNull' call
  var this_0 = tmp;
  return _Result___get_isFailure__impl__jpiriv(this_0) ? null : _Result___get_value__impl__bjfvqg(this_0);
};
protoOf(SyncRules).opFrom_7gr1f6_k$ = function (o) {
  // Inline function 'kotlin.runCatching' call
  var tmp;
  try {
    var tmp_0 = get_jsonPrimitive(getValue(o, 'id')).get_content_h02jrk_k$();
    var tmp_1 = get_jsonPrimitive(getValue(o, 'table')).get_content_h02jrk_k$();
    var tmp_2 = get_jsonPrimitive(getValue(o, 'row')).get_content_h02jrk_k$();
    var tmp_3 = get_jsonObject(getValue(o, 'fields'));
    var tmp_4 = get_jsonPrimitive(getValue(o, 'hlc')).get_content_h02jrk_k$();
    var tmp0_safe_receiver = o.get_6bo4tg_k$('schema');
    var tmp1_safe_receiver = tmp0_safe_receiver == null ? null : get_jsonPrimitive(tmp0_safe_receiver);
    var tmp2_elvis_lhs = tmp1_safe_receiver == null ? null : get_intOrNull(tmp1_safe_receiver);
    // Inline function 'kotlin.Companion.success' call
    var value = new Op(tmp_0, tmp_1, tmp_2, tmp_3, tmp_4, tmp2_elvis_lhs == null ? 0 : tmp2_elvis_lhs);
    tmp = _Result___init__impl__xyqfz8(value);
  } catch ($p) {
    var tmp_5;
    if ($p instanceof Error) {
      var e = $p;
      // Inline function 'kotlin.Companion.failure' call
      tmp_5 = _Result___init__impl__xyqfz8(createFailure(e));
    } else {
      throw $p;
    }
    tmp = tmp_5;
  }
  // Inline function 'kotlin.Result.getOrNull' call
  var this_0 = tmp;
  return _Result___get_isFailure__impl__jpiriv(this_0) ? null : _Result___get_value__impl__bjfvqg(this_0);
};
protoOf(SyncRules).encodeRecord_6y71jh_k$ = function (record) {
  var tmp = to('fields', new JsonObject(record.fields_1));
  // Inline function 'kotlin.collections.mapValues' call
  var this_0 = record.clocks_1;
  // Inline function 'kotlin.collections.mapValuesTo' call
  var destination = LinkedHashMap_init_$Create$_0(mapCapacity(this_0.get_size_woubt6_k$()));
  // Inline function 'kotlin.collections.associateByTo' call
  var _iterator__ex2g4s = this_0.get_entries_p20ztl_k$().iterator_jk1svi_k$();
  while (_iterator__ex2g4s.hasNext_bitz1p_k$()) {
    var element = _iterator__ex2g4s.next_20eer_k$();
    var tmp_0 = element.get_key_18j28a_k$();
    var tmp$ret$4 = JsonPrimitive_0(element.get_value_j01efc_k$());
    destination.put_4fpzoq_k$(tmp_0, tmp$ret$4);
  }
  return (new JsonObject(mapOf([tmp, to('clocks', new JsonObject(destination))]))).toString();
};
protoOf(SyncRules).decodeRecord_ry9ubp_k$ = function (text) {
  var o = get_jsonObject(this.json_1.parseToJsonElement_rqvr2k_k$(text));
  var tmp = get_jsonObject(getValue(o, 'fields'));
  // Inline function 'kotlin.collections.mapValues' call
  var this_0 = get_jsonObject(getValue(o, 'clocks'));
  // Inline function 'kotlin.collections.mapValuesTo' call
  var destination = LinkedHashMap_init_$Create$_0(mapCapacity(this_0.get_size_woubt6_k$()));
  // Inline function 'kotlin.collections.associateByTo' call
  var _iterator__ex2g4s = this_0.get_entries_p20ztl_k$().iterator_jk1svi_k$();
  while (_iterator__ex2g4s.hasNext_bitz1p_k$()) {
    var element = _iterator__ex2g4s.next_20eer_k$();
    var tmp_0 = element.get_key_18j28a_k$();
    var tmp$ret$4 = get_jsonPrimitive(element.get_value_j01efc_k$()).get_content_h02jrk_k$();
    destination.put_4fpzoq_k$(tmp_0, tmp$ret$4);
  }
  return new SyncRecord(tmp, destination);
};
var SyncRules_instance;
function SyncRules_getInstance() {
  if (SyncRules_instance == null)
    new SyncRules();
  return SyncRules_instance;
}
function syncProblem(opJson) {
  var tmp0_elvis_lhs = SyncRules_getInstance().decodeOp_kizvsb_k$(opJson);
  var tmp;
  if (tmp0_elvis_lhs == null) {
    return 'not an op';
  } else {
    tmp = tmp0_elvis_lhs;
  }
  var op = tmp;
  return SyncRules_getInstance().problem_1u3chc_k$(op);
}
function syncMerge(currentJson, opJson) {
  var tmp0 = SyncRules_getInstance().decodeOp_kizvsb_k$(opJson);
  var tmp$ret$0;
  $l$block: {
    // Inline function 'kotlin.requireNotNull' call
    if (tmp0 == null) {
      var message = 'not an op';
      throw IllegalArgumentException_init_$Create$(toString(message));
    } else {
      tmp$ret$0 = tmp0;
      break $l$block;
    }
  }
  var op = tmp$ret$0;
  var tmp;
  if (currentJson == null) {
    tmp = null;
  } else {
    // Inline function 'kotlin.let' call
    tmp = SyncRules_getInstance().decodeRecord_ry9ubp_k$(currentJson);
  }
  var current = tmp;
  return SyncRules_getInstance().encodeRecord_6y71jh_k$(SyncRules_getInstance().merge_mh7e5i_k$(current, op));
}
//region block: exports
export {
  syncProblem as syncProblem,
  syncMerge as syncMerge,
};
//endregion

