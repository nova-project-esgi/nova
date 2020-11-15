import {KeyValue} from '@angular/common';
import {JsonUtils} from './json.utils';
import {QueryUtils} from './query.utils';
import {QueryEnum} from '../enums/query.enum';
import {GetParams} from '../../core/services/http/api-service.base';

export class UrlUtils{

  static getUrlWithQueries(baseUrl: string, ...params: KeyValue<string, any>[]): URL {
    const url = new URL(baseUrl);
    params = this.convertKeyValueArrayEntry(params);
    params.forEach(param => {
      if (param.key.endsWith('[]')){
        url.searchParams.append(param.key,  JsonUtils.stringifyNonString(param.value));
      } else {
        if (!param.value){
          url.searchParams.delete(param.key);
        } else {
          url.searchParams.set(param.key, JsonUtils.stringifyNonString(param.value));
        }
      }
    });
    return url;
  }

  static removeUrlQueries(url: string): string{
    const tmpUrl = new URL(url);
    tmpUrl.searchParams.forEach( k => tmpUrl.searchParams.delete(k));
    return tmpUrl.toString();
  }

  static transformObjToParams(obj: any): KeyValue<string, any>[]{
    const keyVals: KeyValue<string, any>[] = [];
    if (!obj) { return keyVals; }
    Object.keys(obj).forEach( k => {
      keyVals.push({
        key: k,
        value: obj[k]
      });
    });
    return  keyVals;
  }

  static convertKeyValueArrayEntry(keyVal: KeyValue<string, any>[]): KeyValue<string, any>[]{
    const resKeyVal: KeyValue<string, any>[] = [];
    keyVal.forEach(kV => {
      if (Array.isArray(kV.value)){
        kV.value.forEach(v => resKeyVal.push({key: `${kV.key}[]`, value: v}));
      } else {
        resKeyVal.push(kV);
      }
    });
    return resKeyVal;
  }

  static convertPathUrlToKeysValues(textUrl: string): KeyValue<string, number>[]{
    const url = new URL(textUrl);
    const keyValues: KeyValue<string, number>[] = [];
    const segments = url.pathname.split('/');
    for (let i = 0 ; i < segments.length - 1; i++){
      const id = Number(segments[i + 1]);
      if (!isNaN(id)){
        keyValues.push({key: segments[i], value: id});
      }
    }
    return keyValues;
  }
  static convertGetParamsToUrl<P, F = P>(params: GetParams<P, F>): string{
    return UrlUtils.getUrlWithQueries(params.url,
      ...QueryUtils.getFilterQueryFromObj(params.filterObj),
      ...(params.filters ?? []),
      ...QueryUtils.getQueryArrayFromConstructor(params.fieldCtr, QueryEnum.FIELDS),
      ...QueryUtils.getQueryArrayFromPropertiesArray(params.fields, QueryEnum.FIELDS),
      ...QueryUtils.getQueryArrayFromConstructor(params.ascOrderColumnsCtr, QueryEnum.ASC_ORDER_COLUMNS),
      ...QueryUtils.getQueryArrayFromPropertiesArray(params.ascOrderColumns, QueryEnum.ASC_ORDER_COLUMNS),
      ...QueryUtils.getQueryArrayFromConstructor(params.descOrderCtr, QueryEnum.DESC_ORDER_COLUMNS),
      ...QueryUtils.getQueryArrayFromPropertiesArray(params.descOrderColumns, QueryEnum.DESC_ORDER_COLUMNS)
    ).toString();
  }

}
