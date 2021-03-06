<#if swagger.getBasePath()??> <p> <b> Basepath : </b> ${swagger.getBasePath()} </p> </#if>

<ac:structured-macro ac:name="toc">
    <ac:parameter ac:name="style">circle</ac:parameter>
    <ac:parameter ac:name="maxLevel">5</ac:parameter>
    <ac:parameter ac:name="indent">5px</ac:parameter>
    <ac:parameter ac:name="minLevel">1</ac:parameter>
    <ac:parameter ac:name="class">bigpink</ac:parameter>
    <ac:parameter ac:name="exclude">[1//2]</ac:parameter>
    <ac:parameter ac:name="type">list</ac:parameter>
    <ac:parameter ac:name="outline">false</ac:parameter>
    <ac:parameter ac:name="include">.*</ac:parameter>
</ac:structured-macro>

<#if swagger.getPaths()??>
    <#assign paths = swagger.getPaths()/>
    <#list paths?keys as path>
        <h2> ${path}</h2>
        <#assign operation = paths?values[path_index]>

            <#if operation.getGet()??>
                <#assign get = operation.getGet()/>
                <table>
                    <tr>
                        <td  bgcolor="#E6E6FA"> Method </td>
                        <td  bgcolor="#E6E6FA"> GET </td>
                    </tr>
                    <#if get.getSummary()??>
                    <tr>
                        <td>Summary</td>
                        <td>${get.getSummary()}</td>
                    </tr>
                    </#if>
                    <#if get.getDescription()??>
                        <tr>
                            <td>Description</td>
                            <td>${get.getDescription()}</td>
                        </tr>
                    </#if>
                    <#if get.getOperationId()??>
                        <tr>
                            <td>Operation Id</td>
                            <td>${get.getOperationId()}</td>
                        </tr>
                    </#if>
                    <#if get.getProduces()??>
                        <tr>
                            <td> Produces </td>
                            <td>
                                <table>
                                    <#list get.getProduces() as produces>
                                        <td> ${produces} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if get.getConsumes()??>
                        <tr>
                            <td> Consumes </td>
                            <td>
                                <table>
                                    <#list get.getConsumes() as consumes>
                                        <td> ${consumes} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if get.getParameters()??>
                        <tr>
                            <td> Parameters </td>
                            <td>
                                <table>
                                    <tr>
                                        <td> Name </td>
                                        <td> Param Type </td>
                                        <td> Description </td>
                                        <td> Required </td>
                                        <td> Type </td>
                                    </tr>
                                    <#list get.getParameters() as Parameter>
                                        <tr>
                                            <#if Parameter.getName()??> <#assign Pname = Parameter.getName()/>
                                            <#else> <#assign Pname = "-"/>
                                            </#if>
                                            <#if Parameter.getIn()??> <#assign PParamType = Parameter.getIn()/>
                                            <#else> <#assign PParamType = "-"/>
                                            </#if>
                                            <#if Parameter.getDescription()??> <#assign PDescription = Parameter.getDescription()/>
                                            <#else> <#assign PDescription = "-"/>
                                            </#if>
                                            <#if Parameter.getRequired()??> <#assign PRequired = Parameter.getRequired()/>
                                            <#else> <#assign PRequired = "-"/>
                                            </#if>
                                            <#assign ff = 0/>
                                            <#if (Parameter.getType())??> <#assign PType = Parameter.getType()/>
                                            <#else> <#assign PType = "-"/>
                                            </#if>
                                            <#if (Parameter.getSchema())??>
                                                <#if (Parameter.getSchema().getType())??>
                                                    <#assign PType = "array"/>
                                                    <#assign ff = 1/>
                                                <#else>
                                                    <#assign PType = Parameter.getSchema().get$ref()/>
                                                </#if>
                                            </#if>
                                            <td>${Pname}</td>
                                            <td>${PParamType}</td>
                                            <td>${PDescription}</td>
                                            <td><#if PRequired == true> Compulsory <#else> Optional </#if></td>
                                            <#if PType == "array">
                                                <#if ff = 1>
                                                    <td>${"Array["}${Parameter.getSchema().getItems().get$ref()}${"]"}</td>
                                                <#else>
                                                    <#if (Parameter.getItems().getType())??>
                                                        <td>${"Array["}${Parameter.getItems().getType()}${"]"}</td>
                                                    <#else>
                                                        <td>${"Array["}${Parameter.getItems().get$ref()}${"]"}</td>
                                                    </#if>
                                                </#if>
                                            <#else>
                                                <td>${PType}</td>
                                            </#if>
                                        </tr>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if get.getResponses()??>
                        <tr>
                            <td>Responses</td>
                            <#assign responses = get.getResponses()/>
                            <td>
                                <#list responses?keys as responseCode>
                                   <table>
                                       <tr>
                                           <td> Code </td>
                                           <td> ${responseCode} </td>
                                       </tr>
                                       <#if responses?values[responseCode_index].getDescription()??>
                                           <tr>
                                               <td>Description</td>
                                               <td>${responses?values[responseCode_index].getDescription()}</td>
                                           </tr>
                                       </#if>
                                       <#if responses?values[responseCode_index].getSchema()??>
                                           <tr>
                                                <td>Response Schema</td>
                                                <td>
                                                    <#assign array = 0/>
                                                    <#assign ref = 0/>
                                                    <#if responses?values[responseCode_index].getSchema().getType()??>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array">
                                                            <#assign array = 1/>
                                                        </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref">
                                                            <#assign ref = 1/>
                                                        </#if>
                                                    </#if>
                                                    <#if array == 0> <#if ref == 0> ${responses?values[responseCode_index].getSchema().getType()} </#if> </#if>
                                                    <#list models?keys as model>
                                                    <#if responses?values[responseCode_index].getSchema().getType() == "ref"><#if model == responses?values[responseCode_index].getSchema().get$ref()>
                                                       <table>
                                                           <tr>
                                                               <td>
                                                                   <ac:structured-macro ac:name="code">
                                                                       <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                       <ac:plain-text-body><![CDATA[${models[model]}]]></ac:plain-text-body>
                                                                   </ac:structured-macro>
                                                               </td>
                                                               <td>
                                                                   <ac:structured-macro ac:name="code">
                                                                       <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                       <ac:plain-text-body><![CDATA[${schema[model]}]]></ac:plain-text-body>
                                                                   </ac:structured-macro>
                                                               </td>
                                                           </tr>
                                                       </table>
                                                   </#if> </#if>
                                                   <#if responses?values[responseCode_index].getSchema().getType() == "array"><#if model == responses?values[responseCode_index].getSchema().getItems().get$ref()>
                                                       <table>
                                                           <tr>
                                                               <td>
                                                                   <ac:structured-macro ac:name="code">
                                                                       <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                       <ac:plain-text-body><![CDATA[[${models[model]}]]]></ac:plain-text-body>
                                                                   </ac:structured-macro>
                                                               </td>
                                                               <td>
                                                                   <ac:structured-macro ac:name="code">
                                                                       <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                       <ac:plain-text-body><![CDATA[[${schema[model]}]]]></ac:plain-text-body>
                                                                   </ac:structured-macro>
                                                               </td>
                                                           </tr>
                                                       </table>
                                                   </#if> </#if>
                                               </#list>
                                               </td>
                                           </tr>
                                       </#if>
                                       <#if responses?values[responseCode_index].getHeaders()??>
                                           <#assign headers = responses?values[responseCode_index].getHeaders()/>
                                           <tr>
                                               <td> Headers </td>
                                               <td>
                                                   <#list headers?keys as header>
                                                       <p> ${header} : ${headers?values[header_index].getDescription()}</p>
                                                   </#list>
                                               </td>
                                           </tr>
                                       </#if>
                                   </table>
                                </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if get.getSecurity()??>
                        <tr>
                            <td>Security</td>
                            <td>
                                <table>
                                <#list get.getSecurity() as security>
                                        <#list security?keys as auth>
                                            <tr>
                                                <td>
                                                    ${auth}
                                                </td>
                                                <td>
                                                    <#list security?values[auth_index] as auth_list>
                                                       <p>${auth_list}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#list>
                                </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                </table>
            </#if>
            <#if operation.getPut()??>
                <#assign put = operation.getPut()/>
                <table>
                    <tr>
                        <td  bgcolor="#E6E6FA"> Method </td>
                        <td  bgcolor="#E6E6FA"> PUT </td>
                    </tr>
                    <#if put.getSummary()??>
                        <tr>
                            <td>Summary</td>
                            <td>${put.getSummary()}</td>
                        </tr>
                    </#if>
                    <#if put.getDescription()??>
                        <tr>
                            <td>Description</td>
                            <td>${put.getDescription()}</td>
                        </tr>
                    </#if>
                    <#if put.getOperationId()??>
                        <tr>
                            <td>Operation Id</td>
                            <td>${put.getOperationId()}</td>
                        </tr>
                    </#if>
                    <#if put.getProduces()??>
                        <tr>
                            <td> Produces </td>
                            <td>
                                <table>
                                    <#list put.getProduces() as produces>
                                        <td> ${produces} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if put.getConsumes()??>
                        <tr>
                            <td> Consumes </td>
                            <td>
                                <table>
                                    <#list put.getConsumes() as consumes>
                                        <td> ${consumes} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if put.getParameters()??>
                        <tr>
                            <td> Parameters </td>
                            <td>
                                <table>
                                    <tr>
                                        <td> Name </td>
                                        <td> Param Type </td>
                                        <td> Description </td>
                                        <td> Required </td>
                                        <td> Type </td>
                                    </tr>
                                    <#list put.getParameters() as Parameter>
                                        <tr>
                                            <#if Parameter.getName()??> <#assign Pname = Parameter.getName()/>
                                            <#else> <#assign Pname = "-"/>
                                            </#if>
                                            <#if Parameter.getIn()??> <#assign PParamType = Parameter.getIn()/>
                                            <#else> <#assign PParamType = "-"/>
                                            </#if>
                                            <#if Parameter.getDescription()??> <#assign PDescription = Parameter.getDescription()/>
                                            <#else> <#assign PDescription = "-"/>
                                            </#if>
                                            <#if Parameter.getRequired()??> <#assign PRequired = Parameter.getRequired()/>
                                            <#else> <#assign PRequired = "-"/>
                                            </#if>
                                            <#assign ff = 0/>
                                            <#if (Parameter.getType())??> <#assign PType = Parameter.getType()/>
                                            <#else> <#assign PType = "-"/>
                                            </#if>
                                            <#if (Parameter.getSchema())??>
                                                <#if (Parameter.getSchema().getType())??>
                                                    <#assign PType = "array"/>
                                                    <#assign ff = 1/>
                                                <#else>
                                                    <#assign PType = Parameter.getSchema().get$ref()/>
                                                </#if>
                                            </#if>
                                            <td>${Pname}</td>
                                            <td>${PParamType}</td>
                                            <td>${PDescription}</td>
                                            <td><#if PRequired == true> Compulsory <#else> Optional </#if></td>
                                            <#if PType == "array">
                                                <#if ff = 1>
                                                    <td>${"Array["}${Parameter.getSchema().getItems().get$ref()}${"]"}</td>
                                                <#else>
                                                    <#if (Parameter.getItems().getType())??>
                                                        <td>${"Array["}${Parameter.getItems().getType()}${"]"}</td>
                                                    <#else>
                                                        <td>${"Array["}${Parameter.getItems().get$ref()}${"]"}</td>
                                                    </#if>
                                                </#if>
                                            <#else>
                                                <td>${PType}</td>
                                            </#if>
                                        </tr>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if put.getResponses()??>
                        <tr>
                            <td>Responses</td>
                            <#assign responses = put.getResponses()/>
                            <td>
                                <#list responses?keys as responseCode>
                                    <table>
                                        <tr>
                                            <td> Code </td>
                                            <td> ${responseCode} </td>
                                        </tr>
                                        <#if responses?values[responseCode_index].getDescription()??>
                                            <tr>
                                                <td>Description</td>
                                                <td>${responses?values[responseCode_index].getDescription()}</td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getSchema()??>
                                            <tr>
                                                <td>Response Schema</td>
                                                <td>
                                                    <#assign array = 0/>
                                                    <#assign ref = 0/>
                                                    <#if responses?values[responseCode_index].getSchema().getType()??>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array">
                                                            <#assign array = 1/>
                                                        </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref">
                                                            <#assign ref = 1/>
                                                        </#if>
                                                    </#if>
                                                    <#if array == 0> <#if ref == 0> ${responses?values[responseCode_index].getSchema().getType()} </#if> </#if>
                                                    <#list models?keys as model>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref"><#if model == responses?values[responseCode_index].getSchema().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${models[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${schema[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array"><#if model == responses?values[responseCode_index].getSchema().getItems().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${models[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${schema[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getHeaders()??>
                                            <#assign headers = responses?values[responseCode_index].getHeaders()/>
                                            <tr>
                                                <td> Headers </td>
                                                <td>
                                                    <#list headers?keys as header>
                                                        <p> ${header} : ${headers?values[header_index].getDescription()}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                    </table>
                                </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if put.getSecurity()??>
                        <tr>
                            <td>Security</td>
                            <td>
                                <table>
                                    <#list put.getSecurity() as security>
                                        <#list security?keys as auth>
                                            <tr>
                                                <td>
                                                ${auth}
                                                </td>
                                                <td>
                                                    <#list security?values[auth_index] as auth_list>
                                                        <p>${auth_list}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#list>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                </table>
            </#if>
            <#if operation.getPost()??>
                <#assign post = operation.getPost()/>
                <table>
                    <tr>
                        <td  bgcolor="#E6E6FA"> Method </td>
                        <td  bgcolor="#E6E6FA"> POST </td>
                    </tr>
                    <#if post.getSummary()??>
                        <tr>
                            <td>Summary</td>
                            <td>${post.getSummary()}</td>
                        </tr>
                    </#if>
                    <#if post.getDescription()??>
                        <tr>
                            <td>Description</td>
                            <td>${post.getDescription()}</td>
                        </tr>
                    </#if>
                    <#if post.getOperationId()??>
                        <tr>
                            <td>Operation Id</td>
                            <td>${post.getOperationId()}</td>
                        </tr>
                    </#if>
                    <#if post.getProduces()??>
                        <tr>
                            <td> Produces </td>
                            <td>
                                <table>
                                    <#list post.getProduces() as produces>
                                        <td> ${produces} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if post.getConsumes()??>
                        <tr>
                            <td> Consumes </td>
                            <td>
                                <table>
                                    <#list post.getConsumes() as consumes>
                                        <td> ${consumes} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if post.getParameters()??>
                        <tr>
                            <td> Parameters </td>
                            <td>
                                <table>
                                    <tr>
                                        <td> Name </td>
                                        <td> Param Type </td>
                                        <td> Description </td>
                                        <td> Required </td>
                                        <td> Type </td>
                                    </tr>
                                    <#list post.getParameters() as Parameter>
                                        <tr>
                                            <#if Parameter.getName()??> <#assign Pname = Parameter.getName()/>
                                            <#else> <#assign Pname = "-"/>
                                            </#if>
                                            <#if Parameter.getIn()??> <#assign PParamType = Parameter.getIn()/>
                                            <#else> <#assign PParamType = "-"/>
                                            </#if>
                                            <#if Parameter.getDescription()??> <#assign PDescription = Parameter.getDescription()/>
                                            <#else> <#assign PDescription = "-"/>
                                            </#if>
                                            <#if Parameter.getRequired()??> <#assign PRequired = Parameter.getRequired()/>
                                            <#else> <#assign PRequired = "-"/>
                                            </#if>
                                            <#assign ff = 0/>
                                            <#if (Parameter.getType())??> <#assign PType = Parameter.getType()/>
                                            <#else> <#assign PType = "-"/>
                                            </#if>
                                            <#if (Parameter.getSchema())??>
                                                <#if (Parameter.getSchema().getType())??>
                                                    <#assign PType = "array"/>
                                                    <#assign ff = 1/>
                                                <#else>
                                                    <#assign PType = Parameter.getSchema().get$ref()/>
                                                </#if>
                                            </#if>
                                            <td>${Pname}</td>
                                            <td>${PParamType}</td>
                                            <td>${PDescription}</td>
                                            <td><#if PRequired == true> Compulsory <#else> Optional </#if></td>
                                            <#if PType == "array">
                                                <#if ff = 1>
                                                    <td>${"Array["}${Parameter.getSchema().getItems().get$ref()}${"]"}</td>
                                                <#else>
                                                <#if (Parameter.getItems().getType())??>
                                                    <td>${"Array["}${Parameter.getItems().getType()}${"]"}</td>
                                                <#else>
                                                    <td>${"Array["}${Parameter.getItems().get$ref()}${"]"}</td>
                                                </#if>
                                                </#if>
                                            <#else>
                                                <td>${PType}</td>
                                            </#if>
                                        </tr>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if post.getResponses()??>
                        <tr>
                            <td>Responses</td>
                            <#assign responses = post.getResponses()/>
                            <td>
                                <#list responses?keys as responseCode>
                                    <table>
                                        <tr>
                                            <td> Code </td>
                                            <td> ${responseCode} </td>
                                        </tr>
                                        <#if responses?values[responseCode_index].getDescription()??>
                                            <tr>
                                                <td>Description</td>
                                                <td>${responses?values[responseCode_index].getDescription()}</td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getSchema()??>
                                            <tr>
                                                <td>Response Schema</td>
                                                <td>
                                                    <#assign array = 0/>
                                                    <#assign ref = 0/>
                                                    <#if responses?values[responseCode_index].getSchema().getType()??>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array">
                                                            <#assign array = 1/>
                                                        </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref">
                                                            <#assign ref = 1/>
                                                        </#if>
                                                    </#if>
                                                    <#if array == 0> <#if ref == 0> ${responses?values[responseCode_index].getSchema().getType()} </#if> </#if>
                                                    <#list models?keys as model>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref"><#if model == responses?values[responseCode_index].getSchema().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${models[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${schema[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array"><#if model == responses?values[responseCode_index].getSchema().getItems().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${models[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${schema[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getHeaders()??>
                                            <#assign headers = responses?values[responseCode_index].getHeaders()/>
                                            <tr>
                                                <td> Headers </td>
                                                <td>
                                                    <#list headers?keys as header>
                                                        <p> ${header} : ${headers?values[header_index].getDescription()}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                    </table>
                                </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if post.getSecurity()??>
                        <tr>
                            <td>Security</td>
                            <td>
                                <table>
                                    <#list post.getSecurity() as security>
                                        <#list security?keys as auth>
                                            <tr>
                                                <td>
                                                ${auth}
                                                </td>
                                                <td>
                                                    <#list security?values[auth_index] as auth_list>
                                                        <p>${auth_list}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#list>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                </table>
            </#if>

            <#if operation.getDelete()??>
                <table>
                    <#assign delete = operation.getDelete()/>
                    <tr>
                        <td  bgcolor="#E6E6FA"> Method </td>
                        <td  bgcolor="#E6E6FA"> DELETE </td>
                    </tr>
                    <#if delete.getSummary()??>
                        <tr>
                            <td>Summary</td>
                            <td>${delete.getSummary()}</td>
                        </tr>
                    </#if>
                    <#if delete.getOperationId()??>
                        <tr>
                            <td>Operation Id</td>
                            <td>${delete.getOperationId()}</td>
                        </tr>
                    </#if>
                    <#if delete.getProduces()??>
                        <tr>
                            <td> Produces </td>
                            <td>
                                <table>
                                    <#list delete.getProduces() as produces>
                                        <td> ${produces} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if delete.getConsumes()??>
                        <tr>
                            <td> Consumes </td>
                            <td>
                                <#list delete.getConsumes() as consumes> ${consumes} </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if delete.getParameters()??>
                        <tr>
                            <td> Parameters </td>
                            <td>
                                <table>
                                    <tr>
                                        <td> Name </td>
                                        <td> Param Type </td>
                                        <td> Description </td>
                                        <td> Required </td>
                                        <td> Type </td>
                                    </tr>
                                    <#list delete.getParameters() as Parameter>
                                        <tr>
                                            <#if Parameter.getName()??> <#assign Pname = Parameter.getName()/>
                                            <#else> <#assign Pname = "-"/>
                                            </#if>
                                            <#if Parameter.getIn()??> <#assign PParamType = Parameter.getIn()/>
                                            <#else> <#assign PParamType = "-"/>
                                            </#if>
                                            <#if Parameter.getDescription()??> <#assign PDescription = Parameter.getDescription()/>
                                            <#else> <#assign PDescription = "-"/>
                                            </#if>
                                            <#if Parameter.getRequired()??> <#assign PRequired = Parameter.getRequired()/>
                                            <#else> <#assign PRequired = "-"/>
                                            </#if>
                                            <#assign ff = 0/>
                                            <#if (Parameter.getType())??> <#assign PType = Parameter.getType()/>
                                            <#else> <#assign PType = "-"/>
                                            </#if>
                                            <#if (Parameter.getSchema())??>
                                                <#if (Parameter.getSchema().getType())??>
                                                    <#assign PType = "array"/>
                                                    <#assign ff = 1/>
                                                <#else>
                                                    <#assign PType = Parameter.getSchema().get$ref()/>
                                                </#if>
                                            </#if>
                                            <td>${Pname}</td>
                                            <td>${PParamType}</td>
                                            <td>${PDescription}</td>
                                            <td><#if PRequired == true> Compulsory <#else> Optional </#if></td>
                                            <#if PType == "array">
                                                <#if ff = 1>
                                                    <td>${"Array["}${Parameter.getSchema().getItems().get$ref()}${"]"}</td>
                                                <#else>
                                                    <#if (Parameter.getItems().getType())??>
                                                        <td>${"Array["}${Parameter.getItems().getType()}${"]"}</td>
                                                    <#else>
                                                        <td>${"Array["}${Parameter.getItems().get$ref()}${"]"}</td>
                                                    </#if>
                                                </#if>
                                            <#else>
                                                <td>${PType}</td>
                                            </#if>
                                        </tr>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if delete.getResponses()??>
                        <tr>
                            <td>Responses</td>
                            <#assign responses = delete.getResponses()/>
                            <td>
                                <#list responses?keys as responseCode>
                                    <table>
                                        <tr>
                                            <td> Code </td>
                                            <td> ${responseCode} </td>
                                        </tr>
                                        <#if responses?values[responseCode_index].getDescription()??>
                                            <tr>
                                                <td>Description</td>
                                                <td>${responses?values[responseCode_index].getDescription()}</td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getSchema()??>
                                            <tr>
                                                <td>Response Schema</td>
                                                <td>
                                                    <#assign array = 0/>
                                                    <#assign ref = 0/>
                                                    <#if responses?values[responseCode_index].getSchema().getType()??>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array">
                                                            <#assign array = 1/>
                                                        </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref">
                                                            <#assign ref = 1/>
                                                        </#if>
                                                    </#if>
                                                    <#if array == 0> <#if ref == 0> ${responses?values[responseCode_index].getSchema().getType()} </#if> </#if>
                                                    <#list models?keys as model>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref"><#if model == responses?values[responseCode_index].getSchema().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${models[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${schema[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array"><#if model == responses?values[responseCode_index].getSchema().getItems().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${models[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${schema[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getHeaders()??>
                                            <#assign headers = responses?values[responseCode_index].getHeaders()/>
                                            <tr>
                                                <td> Headers </td>
                                                <td>
                                                    <#list headers?keys as header>
                                                        <p> ${header} : ${headers?values[header_index].getDescription()}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                    </table>
                                </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if delete.getSecurity()??>
                        <tr>
                            <td>Security</td>
                            <td>
                                <table>
                                    <#list delete.getSecurity() as security>
                                        <#list security?keys as auth>
                                            <tr>
                                                <td>
                                                ${auth}
                                                </td>
                                                <td>
                                                    <#list security?values[auth_index] as auth_list>
                                                        <p>${auth_list}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#list>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                </table>
            </#if>
            <#if operation.getPatch()??>
                <#assign patch = operation.getPatch()/>
                <table>
                    <tr>
                        <td  bgcolor="#E6E6FA"> Method </td>
                        <td  bgcolor="#E6E6FA"> PATCH </td>
                    </tr>
                    <#if patch.getSummary()??>
                        <tr>
                            <td>Summary</td>
                            <td>${patch.getSummary()}</td>
                        </tr>
                    </#if>
                    <#if patch.getOperationId()??>
                        <tr>
                            <td>Operation Id</td>
                            <td>${patch.getOperationId()}</td>
                        </tr>
                    </#if>
                    <#if patch.getProduces()??>
                        <tr>
                            <td> Produces </td>
                            <td>
                                <table>
                                    <#list patch.getProduces() as produces>
                                        <td> ${produces} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if patch.getConsumes()??>
                        <tr>
                            <td> Consumes </td>
                            <td>
                                <#list patch.getConsumes() as consumes> ${consumes} </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if patch.getParameters()??>
                        <tr>
                            <td> Parameters </td>
                            <td>
                                <table>
                                    <tr>
                                        <td> Name </td>
                                        <td> Param Type </td>
                                        <td> Description </td>
                                        <td> Required </td>
                                        <td> Type </td>
                                    </tr>
                                    <#list patch.getParameters() as Parameter>
                                        <tr>
                                            <#if Parameter.getName()??> <#assign Pname = Parameter.getName()/>
                                            <#else> <#assign Pname = "-"/>
                                            </#if>
                                            <#if Parameter.getIn()??> <#assign PParamType = Parameter.getIn()/>
                                            <#else> <#assign PParamType = "-"/>
                                            </#if>
                                            <#if Parameter.getDescription()??> <#assign PDescription = Parameter.getDescription()/>
                                            <#else> <#assign PDescription = "-"/>
                                            </#if>
                                            <#if Parameter.getRequired()??> <#assign PRequired = Parameter.getRequired()/>
                                            <#else> <#assign PRequired = "-"/>
                                            </#if>
                                            <#assign ff = 0/>
                                            <#if (Parameter.getType())??> <#assign PType = Parameter.getType()/>
                                            <#else> <#assign PType = "-"/>
                                            </#if>
                                            <#if (Parameter.getSchema())??>
                                                <#if (Parameter.getSchema().getType())??>
                                                    <#assign PType = "array"/>
                                                    <#assign ff = 1/>
                                                <#else>
                                                    <#assign PType = Parameter.getSchema().get$ref()/>
                                                </#if>
                                            </#if>
                                            <td>${Pname}</td>
                                            <td>${PParamType}</td>
                                            <td>${PDescription}</td>
                                            <td><#if PRequired == true> Compulsory <#else> Optional </#if></td>
                                            <#if PType == "array">
                                                <#if ff = 1>
                                                    <td>${"Array["}${Parameter.getSchema().getItems().get$ref()}${"]"}</td>
                                                <#else>
                                                    <#if (Parameter.getItems().getType())??>
                                                        <td>${"Array["}${Parameter.getItems().getType()}${"]"}</td>
                                                    <#else>
                                                        <td>${"Array["}${Parameter.getItems().get$ref()}${"]"}</td>
                                                    </#if>
                                                </#if>
                                            <#else>
                                                <td>${PType}</td>
                                            </#if>
                                        </tr>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if patch.getResponses()??>
                        <tr>
                            <td>Responses</td>
                            <#assign responses = patch.getResponses()/>
                            <td>
                                <#list responses?keys as responseCode>
                                    <table>
                                        <tr>
                                            <td> Code </td>
                                            <td> ${responseCode} </td>
                                        </tr>
                                        <#if responses?values[responseCode_index].getDescription()??>
                                            <tr>
                                                <td>Description</td>
                                                <td>${responses?values[responseCode_index].getDescription()}</td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getSchema()??>
                                            <tr>
                                                <td>Response Schema</td>
                                                <td>
                                                    <#assign array = 0/>
                                                    <#assign ref = 0/>
                                                    <#if responses?values[responseCode_index].getSchema().getType()??>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array">
                                                            <#assign array = 1/>
                                                        </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref">
                                                            <#assign ref = 1/>
                                                        </#if>
                                                    </#if>
                                                    <#if array == 0> <#if ref == 0> ${responses?values[responseCode_index].getSchema().getType()} </#if> </#if>
                                                    <#list models?keys as model>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref"><#if model == responses?values[responseCode_index].getSchema().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${models[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${schema[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array"><#if model == responses?values[responseCode_index].getSchema().getItems().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${models[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${schema[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getHeaders()??>
                                            <#assign headers = responses?values[responseCode_index].getHeaders()/>
                                            <tr>
                                                <td> Headers </td>
                                                <td>
                                                    <#list headers?keys as header>
                                                        <p> ${header} : ${headers?values[header_index].getDescription()}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                    </table>
                                </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if patch.getSecurity()??>
                        <tr>
                            <td>Security</td>
                            <td>
                                <table>
                                    <#list patch.getSecurity() as security>
                                        <#list security?keys as auth>
                                            <tr>
                                                <td>
                                                ${auth}
                                                </td>
                                                <td>
                                                    <#list security?values[auth_index] as auth_list>
                                                        <p>${auth_list}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#list>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                </table>
            </#if>
            <#if operation.getOptions()??>
                <#assign options = operation.getOptions()/>
                <table>
                    <tr>
                        <td  bgcolor="#E6E6FA"> Method </td>
                        <td  bgcolor="#E6E6FA"> OPTIONS </td>
                    </tr>
                    <#if options.getSummary()??>
                        <tr>
                            <td>Summary</td>
                            <td>${options.getSummary()}</td>
                        </tr>
                    </#if>
                    <#if options.getOperationId()??>
                        <tr>
                            <td>Operation Id</td>
                            <td>${options.getOperationId()}</td>
                        </tr>
                    </#if>
                    <#if options.getProduces()??>
                        <tr>
                            <td> Produces </td>
                            <td>
                                <table>
                                    <#list options.getProduces() as produces>
                                        <td> ${produces} </td>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if options.getConsumes()??>
                        <tr>
                            <td> Consumes </td>
                            <td>
                                <#list options.getConsumes() as consumes> ${consumes} </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if options.getParameters()??>
                        <tr>
                            <td> Parameters </td>
                            <td>
                                <table>
                                    <tr>
                                        <td> Name </td>
                                        <td> Param Type </td>
                                        <td> Description </td>
                                        <td> Required </td>
                                        <td> Type </td>
                                    </tr>
                                    <#list options.getParameters() as Parameter>
                                        <tr>
                                            <#if Parameter.getName()??> <#assign Pname = Parameter.getName()/>
                                            <#else> <#assign Pname = "-"/>
                                            </#if>
                                            <#if Parameter.getIn()??> <#assign PParamType = Parameter.getIn()/>
                                            <#else> <#assign PParamType = "-"/>
                                            </#if>
                                            <#if Parameter.getDescription()??> <#assign PDescription = Parameter.getDescription()/>
                                            <#else> <#assign PDescription = "-"/>
                                            </#if>
                                            <#if Parameter.getRequired()??> <#assign PRequired = Parameter.getRequired()/>
                                            <#else> <#assign PRequired = "-"/>
                                            </#if>
                                            <#assign ff = 0/>
                                            <#if (Parameter.getType())??> <#assign PType = Parameter.getType()/>
                                            <#else> <#assign PType = "-"/>
                                            </#if>
                                            <#if (Parameter.getSchema())??>
                                                <#if (Parameter.getSchema().getType())??>
                                                    <#assign PType = "array"/>
                                                    <#assign ff = 1/>
                                                <#else>
                                                    <#assign PType = Parameter.getSchema().get$ref()/>
                                                </#if>
                                            </#if>
                                            <td>${Pname}</td>
                                            <td>${PParamType}</td>
                                            <td>${PDescription}</td>
                                            <td><#if PRequired == true> Compulsory <#else> Optional </#if></td>
                                            <#if PType == "array">
                                                <#if ff = 1>
                                                    <td>${"Array["}${Parameter.getSchema().getItems().get$ref()}${"]"}</td>
                                                <#else>
                                                    <#if (Parameter.getItems().getType())??>
                                                        <td>${"Array["}${Parameter.getItems().getType()}${"]"}</td>
                                                    <#else>
                                                        <td>${"Array["}${Parameter.getItems().get$ref()}${"]"}</td>
                                                    </#if>
                                                </#if>
                                            <#else>
                                                <td>${PType}</td>
                                            </#if>
                                        </tr>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                    <#if options.getResponses()??>
                        <tr>
                            <td>Responses</td>
                            <#assign responses = options.getResponses()/>
                            <td>
                                <#list responses?keys as responseCode>
                                    <table>
                                        <tr>
                                            <td> Code </td>
                                            <td> ${responseCode} </td>
                                        </tr>
                                        <#if responses?values[responseCode_index].getDescription()??>
                                            <tr>
                                                <td>Description</td>
                                                <td>${responses?values[responseCode_index].getDescription()}</td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getSchema()??>
                                            <tr>
                                                <td>Response Schema</td>
                                                <td>
                                                    <#assign array = 0/>
                                                    <#assign ref = 0/>
                                                    <#if responses?values[responseCode_index].getSchema().getType()??>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array">
                                                            <#assign array = 1/>
                                                        </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref">
                                                            <#assign ref = 1/>
                                                        </#if>
                                                    </#if>
                                                    <#if array == 0> <#if ref == 0> ${responses?values[responseCode_index].getSchema().getType()} </#if> </#if>
                                                    <#list models?keys as model>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "ref"><#if model == responses?values[responseCode_index].getSchema().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${models[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[${schema[model]}]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                        <#if responses?values[responseCode_index].getSchema().getType() == "array"><#if model == responses?values[responseCode_index].getSchema().getItems().get$ref()>
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${models[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                    <td>
                                                                        <ac:structured-macro ac:name="code">
                                                                            <ac:parameter ac:name="language">javascript</ac:parameter>
                                                                            <ac:plain-text-body><![CDATA[[${schema[model]}]]]></ac:plain-text-body>
                                                                        </ac:structured-macro>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </#if> </#if>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                        <#if responses?values[responseCode_index].getHeaders()??>
                                            <#assign headers = responses?values[responseCode_index].getHeaders()/>
                                            <tr>
                                                <td> Headers </td>
                                                <td>
                                                    <#list headers?keys as header>
                                                        <p> ${header} : ${headers?values[header_index].getDescription()}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#if>
                                    </table>
                                </#list>
                            </td>
                        </tr>
                    </#if>
                    <#if options.getSecurity()??>
                        <tr>
                            <td>Security</td>
                            <td>
                                <table>
                                    <#list options.getSecurity() as security>
                                        <#list security?keys as auth>
                                            <tr>
                                                <td>
                                                ${auth}
                                                </td>
                                                <td>
                                                    <#list security?values[auth_index] as auth_list>
                                                        <p>${auth_list}</p>
                                                    </#list>
                                                </td>
                                            </tr>
                                        </#list>
                                    </#list>
                                </table>
                            </td>
                        </tr>
                    </#if>
                </table>
            </#if>
    </#list>
</#if>

