# This file was generated with the command:
# "./gni-to-cmake.py" "src/compiler.gni" "Compiler.cmake"

# Copyright 2013 The ANGLE Project Authors.All rights reserved.
# Use of this source code is governed by a BSD - style license that can be
# found in the LICENSE file.


set(angle_translator_exported_headers
    "include/GLSLANG/ShaderLang.h"
    "include/GLSLANG/ShaderVars.h"
    "src/compiler/translator/blocklayout.h"
    "src/compiler/translator/blocklayoutHLSL.h"
)


set(angle_translator_sources
    "include/EGL/egl.h"
    "include/EGL/eglext.h"
    "include/EGL/eglplatform.h"
    "include/GLES2/gl2.h"
    "include/GLES2/gl2ext.h"
    "include/GLES2/gl2platform.h"
    "include/GLES3/gl3.h"
    "include/GLES3/gl31.h"
    "include/GLES3/gl32.h"
    "include/GLES3/gl3platform.h"
    "include/KHR/khrplatform.h"
    "include/angle_gl.h"
    "src/compiler/translator/BaseTypes.cpp"
    "src/compiler/translator/BaseTypes.h"
    "src/compiler/translator/BuiltInFunctionEmulator.cpp"
    "src/compiler/translator/BuiltInFunctionEmulator.h"
    "src/compiler/translator/CallDAG.cpp"
    "src/compiler/translator/CallDAG.h"
    "src/compiler/translator/CodeGen.cpp"
    "src/compiler/translator/CollectVariables.cpp"
    "src/compiler/translator/CollectVariables.h"
    "src/compiler/translator/Common.h"
    "src/compiler/translator/Compiler.cpp"
    "src/compiler/translator/Compiler.h"
    "src/compiler/translator/ConstantUnion.cpp"
    "src/compiler/translator/ConstantUnion.h"
    "src/compiler/translator/Declarator.cpp"
    "src/compiler/translator/Declarator.h"
    "src/compiler/translator/Diagnostics.cpp"
    "src/compiler/translator/Diagnostics.h"
    "src/compiler/translator/DirectiveHandler.cpp"
    "src/compiler/translator/DirectiveHandler.h"
    "src/compiler/translator/DriverUniformMetal.h"
    "src/compiler/translator/ExtensionBehavior.cpp"
    "src/compiler/translator/ExtensionBehavior.h"
    "src/compiler/translator/FlagStd140Structs.cpp"
    "src/compiler/translator/FlagStd140Structs.h"
    "src/compiler/translator/FunctionLookup.cpp"
    "src/compiler/translator/FunctionLookup.h"
    "src/compiler/translator/HashNames.cpp"
    "src/compiler/translator/HashNames.h"
    "src/compiler/translator/ImmutableString.h"
    "src/compiler/translator/ImmutableStringBuilder.cpp"
    "src/compiler/translator/ImmutableStringBuilder.h"
    "src/compiler/translator/InfoSink.cpp"
    "src/compiler/translator/InfoSink.h"
    "src/compiler/translator/Initialize.cpp"
    "src/compiler/translator/Initialize.h"
    "src/compiler/translator/InitializeDll.cpp"
    "src/compiler/translator/InitializeDll.h"
    "src/compiler/translator/InitializeGlobals.h"
    "src/compiler/translator/IntermNode.cpp"
    "src/compiler/translator/IntermNode.h"
    "src/compiler/translator/IsASTDepthBelowLimit.cpp"
    "src/compiler/translator/IsASTDepthBelowLimit.h"
    "src/compiler/translator/Operator.cpp"
    "src/compiler/translator/Operator_autogen.h"
    "src/compiler/translator/OutputTree.cpp"
    "src/compiler/translator/OutputTree.h"
    "src/compiler/translator/ParseContext.cpp"
    "src/compiler/translator/ParseContext.h"
    "src/compiler/translator/PoolAlloc.cpp"
    "src/compiler/translator/PoolAlloc.h"
    "src/compiler/translator/Pragma.h"
    "src/compiler/translator/QualifierTypes.cpp"
    "src/compiler/translator/QualifierTypes.h"
    "src/compiler/translator/Severity.h"
    "src/compiler/translator/ShaderLang.cpp"
    "src/compiler/translator/ShaderVars.cpp"
    "src/compiler/translator/StaticType.h"
    "src/compiler/translator/Symbol.cpp"
    "src/compiler/translator/Symbol.h"
    "src/compiler/translator/SymbolTable.cpp"
    "src/compiler/translator/SymbolTable.h"
    "src/compiler/translator/SymbolTable_autogen.h"
    "src/compiler/translator/SymbolUniqueId.cpp"
    "src/compiler/translator/SymbolUniqueId.h"
    "src/compiler/translator/TranslatorESSL.h"
    "src/compiler/translator/TranslatorGLSL.h"
    "src/compiler/translator/TranslatorHLSL.h"
    "src/compiler/translator/TranslatorMetal.h"
    "src/compiler/translator/TranslatorMetalDirect.h"
    "src/compiler/translator/TranslatorVulkan.h"
    "src/compiler/translator/Types.cpp"
    "src/compiler/translator/Types.h"
    "src/compiler/translator/ValidateAST.cpp"
    "src/compiler/translator/ValidateAST.h"
    "src/compiler/translator/ValidateBarrierFunctionCall.cpp"
    "src/compiler/translator/ValidateBarrierFunctionCall.h"
    "src/compiler/translator/ValidateClipCullDistance.cpp"
    "src/compiler/translator/ValidateClipCullDistance.h"
    "src/compiler/translator/ValidateGlobalInitializer.cpp"
    "src/compiler/translator/ValidateGlobalInitializer.h"
    "src/compiler/translator/ValidateLimitations.cpp"
    "src/compiler/translator/ValidateLimitations.h"
    "src/compiler/translator/ValidateMaxParameters.cpp"
    "src/compiler/translator/ValidateMaxParameters.h"
    "src/compiler/translator/ValidateOutputs.cpp"
    "src/compiler/translator/ValidateOutputs.h"
    "src/compiler/translator/ValidateSwitch.cpp"
    "src/compiler/translator/ValidateSwitch.h"
    "src/compiler/translator/ValidateTypeSizeLimitations.cpp"
    "src/compiler/translator/ValidateTypeSizeLimitations.h"
    "src/compiler/translator/ValidateVaryingLocations.cpp"
    "src/compiler/translator/ValidateVaryingLocations.h"
    "src/compiler/translator/VariablePacker.cpp"
    "src/compiler/translator/VariablePacker.h"
    "src/compiler/translator/VersionGLSL.h"
    "src/compiler/translator/blocklayout.cpp"
    "src/compiler/translator/glslang.h"
    "src/compiler/translator/glslang_lex_autogen.cpp"
    "src/compiler/translator/glslang_tab_autogen.cpp"
    "src/compiler/translator/glslang_tab_autogen.h"
    "src/compiler/translator/glslang_wrapper.h"
    "src/compiler/translator/length_limits.h"
    "src/compiler/translator/tree_ops/ClampIndirectIndices.cpp"
    "src/compiler/translator/tree_ops/ClampIndirectIndices.h"
    "src/compiler/translator/tree_ops/ClampPointSize.cpp"
    "src/compiler/translator/tree_ops/ClampPointSize.h"
    "src/compiler/translator/tree_ops/ConvertUnsupportedConstructorsToFunctionCalls.cpp"
    "src/compiler/translator/tree_ops/ConvertUnsupportedConstructorsToFunctionCalls.h"
    "src/compiler/translator/tree_ops/DeclareAndInitBuiltinsForInstancedMultiview.cpp"
    "src/compiler/translator/tree_ops/DeclareAndInitBuiltinsForInstancedMultiview.h"
    "src/compiler/translator/tree_ops/DeferGlobalInitializers.cpp"
    "src/compiler/translator/tree_ops/DeferGlobalInitializers.h"
    "src/compiler/translator/tree_ops/EmulateGLFragColorBroadcast.cpp"
    "src/compiler/translator/tree_ops/EmulateGLFragColorBroadcast.h"
    "src/compiler/translator/tree_ops/EmulateMultiDrawShaderBuiltins.cpp"
    "src/compiler/translator/tree_ops/EmulateMultiDrawShaderBuiltins.h"
    "src/compiler/translator/tree_ops/FoldExpressions.cpp"
    "src/compiler/translator/tree_ops/FoldExpressions.h"
    "src/compiler/translator/tree_ops/ForcePrecisionQualifier.cpp"
    "src/compiler/translator/tree_ops/ForcePrecisionQualifier.h"
    "src/compiler/translator/tree_ops/InitializeVariables.cpp"
    "src/compiler/translator/tree_ops/InitializeVariables.h"
    "src/compiler/translator/tree_ops/MonomorphizeUnsupportedFunctions.cpp"
    "src/compiler/translator/tree_ops/MonomorphizeUnsupportedFunctions.h"
    "src/compiler/translator/tree_ops/NameNamelessUniformBuffers.cpp"
    "src/compiler/translator/tree_ops/NameNamelessUniformBuffers.h"
    "src/compiler/translator/tree_ops/PruneEmptyCases.cpp"
    "src/compiler/translator/tree_ops/PruneEmptyCases.h"
    "src/compiler/translator/tree_ops/PruneNoOps.cpp"
    "src/compiler/translator/tree_ops/PruneNoOps.h"
    "src/compiler/translator/tree_ops/RecordConstantPrecision.cpp"
    "src/compiler/translator/tree_ops/RecordConstantPrecision.h"
    "src/compiler/translator/tree_ops/RemoveArrayLengthMethod.cpp"
    "src/compiler/translator/tree_ops/RemoveArrayLengthMethod.h"
    "src/compiler/translator/tree_ops/RemoveAtomicCounterBuiltins.cpp"
    "src/compiler/translator/tree_ops/RemoveAtomicCounterBuiltins.h"
    "src/compiler/translator/tree_ops/RemoveDynamicIndexing.cpp"
    "src/compiler/translator/tree_ops/RemoveDynamicIndexing.h"
    "src/compiler/translator/tree_ops/RemoveInactiveInterfaceVariables.cpp"
    "src/compiler/translator/tree_ops/RemoveInactiveInterfaceVariables.h"
    "src/compiler/translator/tree_ops/RemoveInvariantDeclaration.cpp"
    "src/compiler/translator/tree_ops/RemoveInvariantDeclaration.h"
    "src/compiler/translator/tree_ops/RemoveUnreferencedVariables.cpp"
    "src/compiler/translator/tree_ops/RemoveUnreferencedVariables.h"
    "src/compiler/translator/tree_ops/RewriteArrayOfArrayOfOpaqueUniforms.cpp"
    "src/compiler/translator/tree_ops/RewriteArrayOfArrayOfOpaqueUniforms.h"
    "src/compiler/translator/tree_ops/RewriteAtomicCounters.cpp"
    "src/compiler/translator/tree_ops/RewriteAtomicCounters.h"
    "src/compiler/translator/tree_ops/RewriteCubeMapSamplersAs2DArray.cpp"
    "src/compiler/translator/tree_ops/RewriteCubeMapSamplersAs2DArray.h"
    "src/compiler/translator/tree_ops/RewriteDfdy.cpp"
    "src/compiler/translator/tree_ops/RewriteDfdy.h"
    "src/compiler/translator/tree_ops/RewritePixelLocalStorage.cpp"
    "src/compiler/translator/tree_ops/RewritePixelLocalStorage.h"
    "src/compiler/translator/tree_ops/RewriteStructSamplers.cpp"
    "src/compiler/translator/tree_ops/RewriteStructSamplers.h"
    "src/compiler/translator/tree_ops/RewriteTexelFetchOffset.cpp"
    "src/compiler/translator/tree_ops/RewriteTexelFetchOffset.h"
    "src/compiler/translator/tree_ops/ScalarizeVecAndMatConstructorArgs.cpp"
    "src/compiler/translator/tree_ops/ScalarizeVecAndMatConstructorArgs.h"
    "src/compiler/translator/tree_ops/SeparateDeclarations.cpp"
    "src/compiler/translator/tree_ops/SeparateDeclarations.h"
    "src/compiler/translator/tree_ops/SeparateStructFromUniformDeclarations.cpp"
    "src/compiler/translator/tree_ops/SeparateStructFromUniformDeclarations.h"
    "src/compiler/translator/tree_ops/SimplifyLoopConditions.cpp"
    "src/compiler/translator/tree_ops/SimplifyLoopConditions.h"
    "src/compiler/translator/tree_ops/SplitSequenceOperator.cpp"
    "src/compiler/translator/tree_ops/SplitSequenceOperator.h"
    "src/compiler/translator/tree_ops/apple/AddAndTrueToLoopCondition.h"
    "src/compiler/translator/tree_ops/apple/RewriteDoWhile.h"
    "src/compiler/translator/tree_ops/apple/RewriteRowMajorMatrices.h"
    "src/compiler/translator/tree_ops/apple/RewriteUnaryMinusOperatorFloat.h"
    "src/compiler/translator/tree_ops/apple/UnfoldShortCircuitAST.h"
    "src/compiler/translator/tree_ops/gl/ClampFragDepth.h"
    "src/compiler/translator/tree_ops/gl/RegenerateStructNames.h"
    "src/compiler/translator/tree_ops/gl/RewriteRepeatedAssignToSwizzled.h"
    "src/compiler/translator/tree_ops/gl/UseInterfaceBlockFields.h"
    "src/compiler/translator/tree_util/AsNode.h"
    "src/compiler/translator/tree_util/BuiltIn.h"
    "src/compiler/translator/tree_util/BuiltIn_ESSL_autogen.h"
    "src/compiler/translator/tree_util/BuiltIn_complete_autogen.h"
    "src/compiler/translator/tree_util/DriverUniform.cpp"
    "src/compiler/translator/tree_util/DriverUniform.h"
    "src/compiler/translator/tree_util/FindFunction.cpp"
    "src/compiler/translator/tree_util/FindFunction.h"
    "src/compiler/translator/tree_util/FindMain.cpp"
    "src/compiler/translator/tree_util/FindMain.h"
    "src/compiler/translator/tree_util/FindPreciseNodes.cpp"
    "src/compiler/translator/tree_util/FindPreciseNodes.h"
    "src/compiler/translator/tree_util/FindSymbolNode.cpp"
    "src/compiler/translator/tree_util/FindSymbolNode.h"
    "src/compiler/translator/tree_util/IntermNodePatternMatcher.cpp"
    "src/compiler/translator/tree_util/IntermNodePatternMatcher.h"
    "src/compiler/translator/tree_util/IntermNode_util.cpp"
    "src/compiler/translator/tree_util/IntermNode_util.h"
    "src/compiler/translator/tree_util/IntermRebuild.cpp"
    "src/compiler/translator/tree_util/IntermRebuild.h"
    "src/compiler/translator/tree_util/IntermTraverse.cpp"
    "src/compiler/translator/tree_util/IntermTraverse.h"
    "src/compiler/translator/tree_util/NodeSearch.h"
    "src/compiler/translator/tree_util/NodeType.h"
    "src/compiler/translator/tree_util/ReplaceArrayOfMatrixVarying.cpp"
    "src/compiler/translator/tree_util/ReplaceArrayOfMatrixVarying.h"
    "src/compiler/translator/tree_util/ReplaceClipCullDistanceVariable.cpp"
    "src/compiler/translator/tree_util/ReplaceClipCullDistanceVariable.h"
    "src/compiler/translator/tree_util/ReplaceShadowingVariables.cpp"
    "src/compiler/translator/tree_util/ReplaceShadowingVariables.h"
    "src/compiler/translator/tree_util/ReplaceVariable.cpp"
    "src/compiler/translator/tree_util/ReplaceVariable.h"
    "src/compiler/translator/tree_util/RewriteSampleMaskVariable.cpp"
    "src/compiler/translator/tree_util/RewriteSampleMaskVariable.h"
    "src/compiler/translator/tree_util/RunAtTheBeginningOfShader.cpp"
    "src/compiler/translator/tree_util/RunAtTheBeginningOfShader.h"
    "src/compiler/translator/tree_util/RunAtTheEndOfShader.cpp"
    "src/compiler/translator/tree_util/RunAtTheEndOfShader.h"
    "src/compiler/translator/tree_util/SpecializationConstant.cpp"
    "src/compiler/translator/tree_util/SpecializationConstant.h"
    "src/compiler/translator/tree_util/Visit.h"
    "src/compiler/translator/util.cpp"
    "src/compiler/translator/util.h"
)
set(angle_translator_glsl_base_sources
    "src/compiler/translator/OutputGLSLBase.cpp"
    "src/compiler/translator/OutputGLSLBase.h"
)
set(angle_translator_glsl_and_vulkan_base_sources
    "src/compiler/translator/BuiltinsWorkaroundGLSL.cpp"
    "src/compiler/translator/BuiltinsWorkaroundGLSL.h"
    "src/compiler/translator/OutputGLSL.cpp"
    "src/compiler/translator/OutputGLSL.h"
)
set(angle_translator_essl_sources
    "src/compiler/translator/OutputESSL.cpp"
    "src/compiler/translator/OutputESSL.h"
    "src/compiler/translator/TranslatorESSL.cpp"
)
set(angle_translator_glsl_sources
    "src/compiler/translator/BuiltInFunctionEmulatorGLSL.cpp"
    "src/compiler/translator/BuiltInFunctionEmulatorGLSL.h"
    "src/compiler/translator/ExtensionGLSL.cpp"
    "src/compiler/translator/ExtensionGLSL.h"
    "src/compiler/translator/TranslatorGLSL.cpp"
    "src/compiler/translator/VersionGLSL.cpp"
    "src/compiler/translator/tree_ops/gl/ClampFragDepth.cpp"
    "src/compiler/translator/tree_ops/gl/RegenerateStructNames.cpp"
    "src/compiler/translator/tree_ops/gl/RewriteRepeatedAssignToSwizzled.cpp"
    "src/compiler/translator/tree_ops/gl/UseInterfaceBlockFields.cpp"
)
set(angle_translator_apple_sources
    "src/compiler/translator/tree_ops/apple/AddAndTrueToLoopCondition.cpp"
    "src/compiler/translator/tree_ops/apple/RewriteDoWhile.cpp"
    "src/compiler/translator/tree_ops/apple/RewriteRowMajorMatrices.cpp"
    "src/compiler/translator/tree_ops/apple/RewriteUnaryMinusOperatorFloat.cpp"
    "src/compiler/translator/tree_ops/apple/UnfoldShortCircuitAST.cpp"
)
set(angle_translator_hlsl_sources
    "src/compiler/translator/ASTMetadataHLSL.cpp"
    "src/compiler/translator/ASTMetadataHLSL.h"
    "src/compiler/translator/AtomicCounterFunctionHLSL.cpp"
    "src/compiler/translator/AtomicCounterFunctionHLSL.h"
    "src/compiler/translator/BuiltInFunctionEmulatorHLSL.cpp"
    "src/compiler/translator/BuiltInFunctionEmulatorHLSL.h"
    "src/compiler/translator/ImageFunctionHLSL.cpp"
    "src/compiler/translator/ImageFunctionHLSL.h"
    "src/compiler/translator/OutputHLSL.cpp"
    "src/compiler/translator/OutputHLSL.h"
    "src/compiler/translator/ResourcesHLSL.cpp"
    "src/compiler/translator/ResourcesHLSL.h"
    "src/compiler/translator/ShaderStorageBlockFunctionHLSL.cpp"
    "src/compiler/translator/ShaderStorageBlockFunctionHLSL.h"
    "src/compiler/translator/ShaderStorageBlockOutputHLSL.cpp"
    "src/compiler/translator/ShaderStorageBlockOutputHLSL.h"
    "src/compiler/translator/StructureHLSL.cpp"
    "src/compiler/translator/StructureHLSL.h"
    "src/compiler/translator/TextureFunctionHLSL.cpp"
    "src/compiler/translator/TextureFunctionHLSL.h"
    "src/compiler/translator/TranslatorHLSL.cpp"
    "src/compiler/translator/UtilsHLSL.cpp"
    "src/compiler/translator/UtilsHLSL.h"
    "src/compiler/translator/blocklayoutHLSL.cpp"
    "src/compiler/translator/emulated_builtin_functions_hlsl_autogen.cpp"
    "src/compiler/translator/tree_ops/d3d/AddDefaultReturnStatements.cpp"
    "src/compiler/translator/tree_ops/d3d/AddDefaultReturnStatements.h"
    "src/compiler/translator/tree_ops/d3d/AggregateAssignArraysInSSBOs.cpp"
    "src/compiler/translator/tree_ops/d3d/AggregateAssignArraysInSSBOs.h"
    "src/compiler/translator/tree_ops/d3d/AggregateAssignStructsInSSBOs.cpp"
    "src/compiler/translator/tree_ops/d3d/AggregateAssignStructsInSSBOs.h"
    "src/compiler/translator/tree_ops/d3d/ArrayReturnValueToOutParameter.cpp"
    "src/compiler/translator/tree_ops/d3d/ArrayReturnValueToOutParameter.h"
    "src/compiler/translator/tree_ops/d3d/BreakVariableAliasingInInnerLoops.cpp"
    "src/compiler/translator/tree_ops/d3d/BreakVariableAliasingInInnerLoops.h"
    "src/compiler/translator/tree_ops/d3d/ExpandIntegerPowExpressions.cpp"
    "src/compiler/translator/tree_ops/d3d/ExpandIntegerPowExpressions.h"
    "src/compiler/translator/tree_ops/d3d/RecordUniformBlocksWithLargeArrayMember.cpp"
    "src/compiler/translator/tree_ops/d3d/RecordUniformBlocksWithLargeArrayMember.h"
    "src/compiler/translator/tree_ops/d3d/RemoveSwitchFallThrough.cpp"
    "src/compiler/translator/tree_ops/d3d/RemoveSwitchFallThrough.h"
    "src/compiler/translator/tree_ops/d3d/RewriteAtomicFunctionExpressions.cpp"
    "src/compiler/translator/tree_ops/d3d/RewriteAtomicFunctionExpressions.h"
    "src/compiler/translator/tree_ops/d3d/RewriteElseBlocks.cpp"
    "src/compiler/translator/tree_ops/d3d/RewriteElseBlocks.h"
    "src/compiler/translator/tree_ops/d3d/RewriteExpressionsWithShaderStorageBlock.cpp"
    "src/compiler/translator/tree_ops/d3d/RewriteExpressionsWithShaderStorageBlock.h"
    "src/compiler/translator/tree_ops/d3d/RewriteUnaryMinusOperatorInt.cpp"
    "src/compiler/translator/tree_ops/d3d/RewriteUnaryMinusOperatorInt.h"
    "src/compiler/translator/tree_ops/d3d/SeparateArrayConstructorStatements.cpp"
    "src/compiler/translator/tree_ops/d3d/SeparateArrayConstructorStatements.h"
    "src/compiler/translator/tree_ops/d3d/SeparateArrayInitialization.cpp"
    "src/compiler/translator/tree_ops/d3d/SeparateArrayInitialization.h"
    "src/compiler/translator/tree_ops/d3d/SeparateExpressionsReturningArrays.cpp"
    "src/compiler/translator/tree_ops/d3d/SeparateExpressionsReturningArrays.h"
    "src/compiler/translator/tree_ops/d3d/UnfoldShortCircuitToIf.cpp"
    "src/compiler/translator/tree_ops/d3d/UnfoldShortCircuitToIf.h"
    "src/compiler/translator/tree_ops/d3d/WrapSwitchStatementsInBlocks.cpp"
    "src/compiler/translator/tree_ops/d3d/WrapSwitchStatementsInBlocks.h"
)
set(angle_translator_lib_vulkan_sources
    "src/compiler/translator/BuildSPIRV.cpp"
    "src/compiler/translator/BuildSPIRV.h"
    "src/compiler/translator/OutputSPIRV.cpp"
    "src/compiler/translator/OutputSPIRV.h"
    "src/compiler/translator/OutputVulkanGLSL.cpp"
    "src/compiler/translator/OutputVulkanGLSL.h"
    "src/compiler/translator/TranslatorVulkan.cpp"
    "src/compiler/translator/tree_ops/vulkan/DeclarePerVertexBlocks.cpp"
    "src/compiler/translator/tree_ops/vulkan/DeclarePerVertexBlocks.h"
    "src/compiler/translator/tree_ops/vulkan/EmulateAdvancedBlendEquations.cpp"
    "src/compiler/translator/tree_ops/vulkan/EmulateAdvancedBlendEquations.h"
    "src/compiler/translator/tree_ops/vulkan/EmulateDithering.cpp"
    "src/compiler/translator/tree_ops/vulkan/EmulateDithering.h"
    "src/compiler/translator/tree_ops/vulkan/EmulateFragColorData.cpp"
    "src/compiler/translator/tree_ops/vulkan/EmulateFragColorData.h"
    "src/compiler/translator/tree_ops/vulkan/EmulateYUVBuiltIns.cpp"
    "src/compiler/translator/tree_ops/vulkan/EmulateYUVBuiltIns.h"
    "src/compiler/translator/tree_ops/vulkan/FlagSamplersWithTexelFetch.cpp"
    "src/compiler/translator/tree_ops/vulkan/FlagSamplersWithTexelFetch.h"
    "src/compiler/translator/tree_ops/vulkan/ReplaceForShaderFramebufferFetch.cpp"
    "src/compiler/translator/tree_ops/vulkan/ReplaceForShaderFramebufferFetch.h"
    "src/compiler/translator/tree_ops/vulkan/RewriteInterpolateAtOffset.cpp"
    "src/compiler/translator/tree_ops/vulkan/RewriteInterpolateAtOffset.h"
    "src/compiler/translator/tree_ops/vulkan/RewriteR32fImages.cpp"
    "src/compiler/translator/tree_ops/vulkan/RewriteR32fImages.h"
)


set(angle_translator_essl_symbol_table_sources
    "src/compiler/translator/ImmutableString_ESSL_autogen.cpp"
    "src/compiler/translator/SymbolTable_ESSL_autogen.cpp"
)
set(angle_translator_glsl_symbol_table_sources
    "src/compiler/translator/ImmutableString_autogen.cpp"
    "src/compiler/translator/SymbolTable_autogen.cpp"
)


set(angle_translator_lib_metal_sources
    "src/compiler/translator/DriverUniformMetal.cpp"
    "src/compiler/translator/TranslatorMetal.cpp"
    "src/compiler/translator/TranslatorMetalConstantNames.cpp"
    "src/compiler/translator/TranslatorMetalDirect.cpp"
    "src/compiler/translator/TranslatorMetalDirect/AddExplicitTypeCasts.cpp"
    "src/compiler/translator/TranslatorMetalDirect/AddExplicitTypeCasts.h"
    "src/compiler/translator/TranslatorMetalDirect/AstHelpers.cpp"
    "src/compiler/translator/TranslatorMetalDirect/AstHelpers.h"
    "src/compiler/translator/TranslatorMetalDirect/DebugSink.h"
    "src/compiler/translator/TranslatorMetalDirect/DiscoverDependentFunctions.cpp"
    "src/compiler/translator/TranslatorMetalDirect/DiscoverDependentFunctions.h"
    "src/compiler/translator/TranslatorMetalDirect/DiscoverEnclosingFunctionTraverser.cpp"
    "src/compiler/translator/TranslatorMetalDirect/DiscoverEnclosingFunctionTraverser.h"
    "src/compiler/translator/TranslatorMetalDirect/EmitMetal.cpp"
    "src/compiler/translator/TranslatorMetalDirect/EmitMetal.h"
    "src/compiler/translator/TranslatorMetalDirect/FixTypeConstructors.cpp"
    "src/compiler/translator/TranslatorMetalDirect/FixTypeConstructors.h"
    "src/compiler/translator/TranslatorMetalDirect/GuardFragDepthWrite.cpp"
    "src/compiler/translator/TranslatorMetalDirect/GuardFragDepthWrite.h"
    "src/compiler/translator/TranslatorMetalDirect/HoistConstants.cpp"
    "src/compiler/translator/TranslatorMetalDirect/HoistConstants.h"
    "src/compiler/translator/TranslatorMetalDirect/IdGen.cpp"
    "src/compiler/translator/TranslatorMetalDirect/IdGen.h"
    "src/compiler/translator/TranslatorMetalDirect/IntroduceVertexIndexID.cpp"
    "src/compiler/translator/TranslatorMetalDirect/IntroduceVertexIndexID.h"
    "src/compiler/translator/TranslatorMetalDirect/Layout.cpp"
    "src/compiler/translator/TranslatorMetalDirect/Layout.h"
    "src/compiler/translator/TranslatorMetalDirect/MapFunctionsToDefinitions.cpp"
    "src/compiler/translator/TranslatorMetalDirect/MapFunctionsToDefinitions.h"
    "src/compiler/translator/TranslatorMetalDirect/MapSymbols.cpp"
    "src/compiler/translator/TranslatorMetalDirect/MapSymbols.h"
    "src/compiler/translator/TranslatorMetalDirect/ModifyStruct.cpp"
    "src/compiler/translator/TranslatorMetalDirect/ModifyStruct.h"
    "src/compiler/translator/TranslatorMetalDirect/Name.cpp"
    "src/compiler/translator/TranslatorMetalDirect/Name.h"
    "src/compiler/translator/TranslatorMetalDirect/NameEmbeddedUniformStructsMetal.cpp"
    "src/compiler/translator/TranslatorMetalDirect/NameEmbeddedUniformStructsMetal.h"
    "src/compiler/translator/TranslatorMetalDirect/Pipeline.cpp"
    "src/compiler/translator/TranslatorMetalDirect/Pipeline.h"
    "src/compiler/translator/TranslatorMetalDirect/ProgramPrelude.cpp"
    "src/compiler/translator/TranslatorMetalDirect/ProgramPrelude.h"
    "src/compiler/translator/TranslatorMetalDirect/ReduceInterfaceBlocks.cpp"
    "src/compiler/translator/TranslatorMetalDirect/ReduceInterfaceBlocks.h"
    "src/compiler/translator/TranslatorMetalDirect/Reference.h"
    "src/compiler/translator/TranslatorMetalDirect/RewriteCaseDeclarations.cpp"
    "src/compiler/translator/TranslatorMetalDirect/RewriteCaseDeclarations.h"
    "src/compiler/translator/TranslatorMetalDirect/RewriteOutArgs.cpp"
    "src/compiler/translator/TranslatorMetalDirect/RewriteOutArgs.h"
    "src/compiler/translator/TranslatorMetalDirect/RewritePipelines.cpp"
    "src/compiler/translator/TranslatorMetalDirect/RewritePipelines.h"
    "src/compiler/translator/TranslatorMetalDirect/RewriteUnaddressableReferences.cpp"
    "src/compiler/translator/TranslatorMetalDirect/RewriteUnaddressableReferences.h"
    "src/compiler/translator/TranslatorMetalDirect/SeparateCompoundExpressions.cpp"
    "src/compiler/translator/TranslatorMetalDirect/SeparateCompoundExpressions.h"
    "src/compiler/translator/TranslatorMetalDirect/SeparateCompoundStructDeclarations.cpp"
    "src/compiler/translator/TranslatorMetalDirect/SeparateCompoundStructDeclarations.h"
    "src/compiler/translator/TranslatorMetalDirect/SkippingTraverser.h"
    "src/compiler/translator/TranslatorMetalDirect/SymbolEnv.cpp"
    "src/compiler/translator/TranslatorMetalDirect/SymbolEnv.h"
    "src/compiler/translator/TranslatorMetalDirect/ToposortStructs.cpp"
    "src/compiler/translator/TranslatorMetalDirect/ToposortStructs.h"
    "src/compiler/translator/TranslatorMetalDirect/TranslatorMetalUtils.cpp"
    "src/compiler/translator/TranslatorMetalDirect/TranslatorMetalUtils.h"
    "src/compiler/translator/TranslatorMetalDirect/TransposeRowMajorMatrices.cpp"
    "src/compiler/translator/TranslatorMetalDirect/TransposeRowMajorMatrices.h"
    "src/compiler/translator/TranslatorMetalDirect/WrapMain.cpp"
    "src/compiler/translator/TranslatorMetalDirect/WrapMain.h"
)


set(angle_preprocessor_sources
    "src/compiler/preprocessor/DiagnosticsBase.cpp"
    "src/compiler/preprocessor/DiagnosticsBase.h"
    "src/compiler/preprocessor/DirectiveHandlerBase.cpp"
    "src/compiler/preprocessor/DirectiveHandlerBase.h"
    "src/compiler/preprocessor/DirectiveParser.cpp"
    "src/compiler/preprocessor/DirectiveParser.h"
    "src/compiler/preprocessor/ExpressionParser.h"
    "src/compiler/preprocessor/Input.cpp"
    "src/compiler/preprocessor/Input.h"
    "src/compiler/preprocessor/Lexer.cpp"
    "src/compiler/preprocessor/Lexer.h"
    "src/compiler/preprocessor/Macro.cpp"
    "src/compiler/preprocessor/Macro.h"
    "src/compiler/preprocessor/MacroExpander.cpp"
    "src/compiler/preprocessor/MacroExpander.h"
    "src/compiler/preprocessor/Preprocessor.cpp"
    "src/compiler/preprocessor/Preprocessor.h"
    "src/compiler/preprocessor/SourceLocation.h"
    "src/compiler/preprocessor/Token.cpp"
    "src/compiler/preprocessor/Token.h"
    "src/compiler/preprocessor/Tokenizer.h"
    "src/compiler/preprocessor/numeric_lex.h"
    "src/compiler/preprocessor/preprocessor_lex_autogen.cpp"
    "src/compiler/preprocessor/preprocessor_tab_autogen.cpp"
)
