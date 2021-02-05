### 创建新的xql：

```
module namespace prefixe="http://localhost:8080/exist/apps/appName/prefixe";

declare function prefixe:fonctionName($node as node(), $model as map(*), $parametre as xs:string) as element(htmlElement1){
	<htmlElement1>{use this if not text}</htmlElement1>
}
```


### 在view中添加路径
`import module namespace prefixe="http://localhost:8080/exist/apps/apps/appName/prefixe" at "fileName.xql";`

### 在html中引用
`<div data-template="prefixe:fonctionName" data-template-parametreName="valeur"/>`

**Attention: n'importe quel nom donné dans la ligne de déclaration, ou dans quel élément on appelle la fonction, dans la code sources d'exécution, on ne voit que ce qui est dans la fonction, `htmlElement1`**


