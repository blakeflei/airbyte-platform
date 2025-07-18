/*
 * Copyright (c) 2020-2025 Airbyte, Inc., all rights reserved.
 */

package io.airbyte.commons.server.validation

import io.airbyte.commons.server.errors.ApplicationErrorKnownException
import jakarta.inject.Singleton
import java.util.UUID

/**
 * Default Community edition implementation of [ActorDefinitionAccessValidator]. Does nothing,
 * because Community edition does not have any access restrictions/auth.
 */
@Singleton
class CommunityActorDefinitionAccessValidator : ActorDefinitionAccessValidator {
  @Throws(ApplicationErrorKnownException::class)
  override fun validateWriteAccess(actorDefinitionId: UUID) {
    // do nothing
  }
}
